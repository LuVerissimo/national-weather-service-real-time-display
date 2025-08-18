defmodule WebWeb.GRPC.WeatherServer do
  use GRPC.Server, service: Weather.WeatherService.Service

  import Ecto.Query, only: [from: 2]
  alias Core.Repo
  alias Core.Station.ReadModels.Observation

  def get_observation(%Weather.GetObservationRequest{station_id: id}, _stream) do
    query =
      from(o in Observation,
        where: o.station_id == ^id,
        order_by: [desc: o.observed_at],
        limit: 1
      )

    case Repo.one(query) do
      nil ->
        {:error, :not_found, "Observation not found"}

      obs ->
        %Weather.Observation{
          station_id: obs.station_id,
          temperature: obs.temperature,
          humidity: obs.humidity,
          wind_speed: obs.wind_speed,
          observed_at: DateTime.to_iso8601(obs.observed_at)
        }
    end
  end

  def get_all_observations(%Weather.GetObservationRequest{station_id: id}, _stream) do
    query =
      from(o in Observation,
        where: o.station_id == ^id,
        order_by: [desc: o.observed_at]
      )

    observations = Repo.all(query)

    obs_list =
      Enum.map(observations, fn obs ->
        %Weather.Observation{
          station_id: obs.station_id,
          temperature: obs.temperature,
          humidity: obs.humidity,
          wind_speed: obs.wind_speed,
          observed_at: DateTime.to_iso8601(obs.observed_at)
        }
      end)

    %Weather.Observations{observations: obs_list}
  end

  # def get_all(_req, _stream) do
  #   observations = Repo.all(Observation)

  #   obs_list =
  #     Enum.map(observations, fn obs ->
  #       %Weather.Observation{
  #         station_id: obs.station_id,
  #         temperature: obs.temperature,
  #         humidity: obs.humidity,
  #         wind_speed: obs.wind_speed,
  #         observed_at: DateTime.to_iso8601(obs.observed_at)
  #       }
  #     end)

  #   %Weather.Observations{observations: obs_list}
  # end
end
