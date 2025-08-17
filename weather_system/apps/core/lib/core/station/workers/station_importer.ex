defmodule Core.Station.Workers.StationImporter do
  use Oban.Worker,
    queue: :default,
    max_attempts: 3

  alias Core.Station.Workers.FetchStationDataWorker

  # Use to periodically fetch a list of active weather stations
  # then enqueue individual jobs to fetch data for each one.

  @impl Oban.Worker
  def perform(_args) do
    # fetch from list of external stations
    stations = ["025PG", "045PG", "119SE"]

    # For each station, enqueue another job to fetch data with FetchStationDataWorker
    # Enqueuing Jobs
    # All workers implement a new/2 function that converts an args map
    # into a job changeset suitable for inserting into the database for later execution:

    jobs =
      Enum.map(stations, fn station_id ->
        IO.puts("Enqueuing job for station #{station_id}")
        %{station_id: station_id} |> FetchStationDataWorker.new()
      end)

    Oban.insert_all(jobs)

    :ok
  end
end
