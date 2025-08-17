defmodule Core.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      #Ecto repo
      Core.Repo,
      #Commanded App
      Core.App,
      # Oban supervisor
      {Oban, Application.get_env(:core, Oban)}
    ]

    opts = [strategy: :one_for_one, name: Core.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
