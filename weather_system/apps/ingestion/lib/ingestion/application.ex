defmodule Ingestion.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Ingestion.WeatherPipeline
    ]

    opts = [strategy: :one_for_one, name: Ingestion.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
