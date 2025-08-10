defmodule Core.Application do
  use Application
  use Commanded.Application,
    otp_app: :core,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Core.EventStore
    ]


  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Core.Worker.start_link(arg)
      # {Core.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Core.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
