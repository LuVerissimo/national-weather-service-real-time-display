defmodule Ingestion.MixProject do
  use Mix.Project

  def project do
    [
      app: :ingestion,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Ingestion.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:broadway, "~> 1.2"},
      {:broadway_kafka, "~> 0.4"},
      {:finch, "~> 0.13"},
      {:jason, "~> 1.2"},
    ]
  end
end
