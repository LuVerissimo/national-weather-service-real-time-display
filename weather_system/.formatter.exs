# Used by "mix format"
[
  import_deps: [:ecto, :phoenix],
  plugins: [Phoenix.LiveView.HTMLFormatter],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  inputs: ["mix.exs", "config/*.exs"],
  subdirectories: ["apps/*"]
]
