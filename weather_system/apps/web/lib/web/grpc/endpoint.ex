defmodule Web.GRPC.Endpoint do
  use GRPC.Endpoint

  intercept(GRPC.Server.Interceptors.Logger)
  run(Web.GRPC.WeatherServer)
end
