defmodule WebWeb.GRPC.Endpoint do
  use GRPC.Endpoint

  intercept(GRPC.Server.Interceptors.Logger)
  run(WebWeb.GRPC.WeatherServer)
end
