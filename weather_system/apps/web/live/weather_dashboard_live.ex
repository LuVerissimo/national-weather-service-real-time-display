defmodule Web.WeatherDashboardLive do
  use Phoenix.LiveView
  alias Core.Station.ReadModels.Observation
  alias Core.Repo

  # subscribe and fetch initial weather data
  def mount(_params, _session, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(Web.PubSub, "weather_updates")

    # Fetch from read model
    observations = Repo.all(Observation)

    {:ok, assign(socket, :observations, observations)}
  end

  def render(assigns) do
    ~H"""
    <h1>Weather Dashboard</h1>
    <div id="dashboard">
      <%= for observation <- @observations do %>
        <div class="observation">
          <h2><%= observation.station_id %></h2>

          <p><strong>Humidity: </strong> <%= observation.humidity %></p>
          <p><strong>Temperature: </strong> <%= observation.temperature %>°C</p>
          <p><strong>Wind Speed: </strong> <%= observation.wind_speed %></p>
          <p><strong>Observed at: </strong> <%= observation.observed_at %></p>
        </div>
      <% end %>
    </div>
    """
  end

  #  Fired when project broadcasts an update
  def handle_info({:new_observation, observation}, socket) do
    # Prepending instead of updating existing entry because this isn't a real app
    new_observations = [observation | socket.assign.observations]
    {:noreply, assign(socket, :observations, new_observations)}
  end
end
