defmodule Core.MixProject do
  use Mix.Project

  def project do
    [
      app: :core,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
  [
    mod: {Core.Application, []},
    extra_applications: [:logger, :runtime_tools, :commanded, :eventstore, :ecto_sql]
  ]
end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:commanded, "~> 1.4"},
      {:eventstore, "~> 1.4"},
      {:commanded_eventstore_adapter, "~> 1.4"},
      {:jason, "~> 1.4"},
      {:postgrex, ">= 0.0.0"},
      {:ecto_sql, "~> 3.11"}
    ]
  end
end
