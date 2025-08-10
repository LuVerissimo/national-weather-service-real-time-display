# Core

**This will house our core business logic, including Commanded aggregates, commands, and events.**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `core` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:core, "~> 0.1.0"}
    {:commanded, "~> 1.4"},
    {:commanded_eventstore_adapter, "~> 1.4"},
    {:jason, "~> 1.4"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/core>.

