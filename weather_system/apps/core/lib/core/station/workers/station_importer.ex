defmodule Core.Station.Workers.StationImporter do
  use Oban.Worker,
    queue: :default,
    max_attempts: 3

  alias Core.Station.Workers.FetchStationDataWorker
  alias Web.PubSub

  # Use to periodically fetch a list of active weather stations
  # then enqueue individual jobs to fetch data for each one.

  # For each station, enqueue another job to fetch data with FetchStationDataWorker
  @impl Oban.Worker
  def perform(_args) do
    stations = ["025PG", "045PG", "119SE"]

    Enum.each(stations, fn station_id ->
      # Insert job to fetch observation
      %{station_id: station_id}
      |> FetchStationDataWorker.new()
      |> Oban.insert!()

      # Broadcast that job has been enqueued
      Phoenix.PubSub.broadcast(PubSub, "weather_updates", {:job_enqueued, station_id})
      IO.puts("Enqueued job for station #{station_id}")
    end)

    :ok
  end
end
