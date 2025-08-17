# WeatherSystem

**TODO: Add description**

Install Requirements:
* Docker
* Docker-Compose
* Postgres




## Weather System Data Flow
```mermaid
flowchart TD
    %% Data Fetching Layer
    subgraph Data_Fetching["Data Fetching (Oban Workers)"]
        A[StationImporter Worker<br/>(Enqueues FetchStationDataWorker jobs)] -->|Enqueue job with %{station_id}| B[FetchStationDataWorker<br/>(HTTP GET external API)]
        B -->|GET /stations/:id/observation/latest<br/>returns JSON| C[External Weather API]
        C -->|Convert JSON to command| D[Command: RecordObservation<br/>{station_id, temperature, humidity, wind_speed, observed_at}]
    end

    %% Domain Logic Layer
    subgraph Domain_Logic["Domain Logic (Commanded Aggregate)"]
        D --> E[Aggregate: Core.Station.Aggregate<br/>Validates command, produces event]
        E --> F[Event: ObservationRecorded<br/>{station_id, temperature, humidity, wind_speed, observed_at}]
    end

    %% Projection Layer
    subgraph Projection["Projection Layer (Read Model + PubSub)"]
        F --> G[ObservationProjector<br/>Updates Read Model (Observation table)<br/>Broadcasts via PubSub "weather_updates"]
        G -->|Insert/Update| H[Read Model: Observation table (Postgres)]
        G -->|Phoenix.PubSub broadcast| I[LiveView: WebWeb.WeatherDashboardLive<br/>Subscribes to "weather_updates"]
    end

    %% Frontend Layer
    subgraph Frontend["Frontend (LiveView Dashboard)"]
        I --> J[User Interface: Displays latest weather data in real-time<br/>Temperature, Humidity, Wind Speed, Timestamp]
    end
```



## Step-by-step Explanation

###  1. Job Scheduling with Oban

* StationImporter periodically fetches a list of active weather stations.

* It enqueues FetchStationDataWorker jobs for each station.

### 2. Fetching Weather Data

* FetchStationDataWorker performs HTTP requests to the external weather API.

* It receives JSON data about temperature, humidity, wind speed, etc.

* Converts this data into a Command: %RecordObservation{}.

### 3. Command Handling

* The RecordObservation command is dispatched to the Aggregate (Core.Station.Aggregate).

* Aggregate validates the command and produces an Event (ObservationRecorded).

### 4. Event Projection

* ObservationProjector listens to ObservationRecorded events.

* Updates the Read Model (Ecto table) for fast querying.

* Broadcasts the new observation using Phoenix.PubSub on "weather_updates" topic.

### 5. LiveView Updates

* WebWeb.WeatherDashboardLive subscribes to "weather_updates".

* Receives the broadcasted event and prepends the new observation to the dashboard.

* The dashboard updates in real-time without a page refresh.

### 6. User Dashboard

* Users see the updated weather data in near real-time.