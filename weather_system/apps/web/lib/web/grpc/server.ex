defmodule Web.GRPC.WeatherServer do
  use GRPC.Server, service: Weather.WeatherService.Service

  alias Core.Repo
  alias Core.Station.ReadModels.Observation

  # @doc """
  # Wrap function call and handle gRPC errors
  # Return protobuf struct | {:error, code, message}
  # """

  # defp handle_grpc_error(fun) do
  #   try do
  #     fun.()
  #   rescue
  #     e in Ecto.NoResultsError ->
  #       {:error, :not_found, "Resource not found #{e.message}"}

  #     e ->
  #       {:error, :internal, "Internal server error: #{Exception.message(e)}"}
  #   end
  # end

  def get_observation(req, _stream) do
    case Repo.get(Observation, req.station_id) do
      nil ->
        {:error, :not_found, "Observation not found"}

      observation ->
        %Weather.Observation{
          station_id: observation.station_id,
          temperature: observation.temperature,
          humidity: observation.humidity,
          wind_speed: observation.wind_speed,
          observed_at: DateTime.to_iso8601(observation.observed_at)
        }
    end
  end
end
