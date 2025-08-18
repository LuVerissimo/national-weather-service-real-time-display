defmodule Weather.GetObservationRequest do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :station_id, 1, type: :string, json_name: "stationId"
end

defmodule Weather.Observation do
  @moduledoc false

  use Protobuf, protoc_gen_elixir_version: "0.15.0", syntax: :proto3

  field :station_id, 1, type: :string, json_name: "stationId"
  field :temperature, 2, type: :float
  field :humidity, 3, type: :float
  field :wind_speed, 4, type: :float, json_name: "windSpeed"
  field :observed_at, 5, type: :string, json_name: "observedAt"
end

defmodule Weather.WeatherService.Service do
  @moduledoc false

  use GRPC.Service, name: "weather.WeatherService", protoc_gen_elixir_version: "0.15.0"

  rpc :GetObservation, Weather.GetObservationRequest, Weather.Observation
end

defmodule Weather.WeatherService.Stub do
  @moduledoc false

  use GRPC.Stub, service: Weather.WeatherService.Service
end
