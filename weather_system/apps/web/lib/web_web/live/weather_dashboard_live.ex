defmodule WebWeb.WeatherDashboardLive do
  use Phoenix.LiveView
  alias Core.Station.ReadModels.Observation
  alias Core.Repo
  alias Web.PubSub

  # subscribe and fetch initial weather data
  def mount(_params, _session, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(PubSub, "weather_updates")

    # Fetch from read model
    observations = Repo.all(Observation)

    {:ok,
     assign(socket,
       observations: observations,
       jobs: []
     )}
  end

  def render(assigns) do
    ~H"""
    <h1>Weather Dashboard</h1>
    <div id="dashboard">
      <%= for obs <- @observations do %>
        <div class="observation">
          <h2><%= obs.station_id %></h2>

          <p><strong>Humidity: </strong> <%= obs.humidity %></p>
          <p><strong>Temperature: </strong> <%= obs.temperature %>°C</p>
          <p><strong>Wind Speed: </strong> <%= obs.wind_speed %></p>
          <p><strong>Observed at: </strong> <%= obs.observed_at %></p>
        </div>
      <% end %>
    </div>
    """
  end

  #  Fired when project broadcasts an update
  def handle_info({:new_observation, observation}, socket) do
    # Prepending instead of updating existing entry because this isn't a real app
    new_observations = [observation | socket.assigns.observations]
    {:noreply, assign(socket, :observations, new_observations)}
  end

  def handle_info({:job_enqueued, station_id}, socket) do
    new_jobs = [station_id | socket.assigns.jobs]
    {:noreply, assign(socket, :jobs, new_jobs)}
  end

  # catch all
  def handle_info(msg, socket) do
    IO.inspect(msg, label: "Unhandled msg in LiveView")
    {:noreply, socket}
  end
end
