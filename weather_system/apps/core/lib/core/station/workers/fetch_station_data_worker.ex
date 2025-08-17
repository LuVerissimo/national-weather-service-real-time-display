defmodule Core.Station.Workers.FetchStationDataWorker do
  use Oban.Worker,
    queue: :default,
    max_attempts: 5

  alias Core.Station.Commands.RecordObservation

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"station_id" => station_id}}) do
    with {:ok, observation} <- fetch_observation(station_id) do
      %RecordObservation{
        station_id: station_id,
        temperature: observation.temperature,
        humidity: observation.humidity,
        wind_speed: observation.wind_speed,
        observed_at: observation.observed_at
      }
      |> Core.App.dispatch()
    end
  end

  defp fetch_observation(station_id) do
    url = "http://api.weather.gov/stations/#{station_id}/observation/latest"
    headers = [{"User-Agent", "weather_system/0.1.0"}]

    with {:ok, %{status: 200, body: body}} <-
           Finch.build(:get, url, headers) |> Finch.request(Core.Finch),
         {:ok, data} <- Jason.decode(body) do
      parse_observation(data)
    else
      {:error, error} ->
        {:error, "Failed to fetch observation for #{station_id}: #{inspect(error)}"}
    end
  end

  defp parse_observation(%{"properties" => props}) do
    with {:ok, observed_at, _} <- DateTime.from_iso8601(props["timestamp"]),
         temperature <- get_in(props, ["temperature", "value"]),
         humidity <- get_in(props, ["humidity", "value"]),
         wind_speed <- get_in(props, ["wind_speed", "value"]) do
      {:ok,
       %{
         temperature: temperature,
         humidity: humidity,
         wind_speed: wind_speed,
         observed_at: observed_at
       }}
    else
      _ -> {:error, "Failed parse observation properties"}
    end
  end
end
