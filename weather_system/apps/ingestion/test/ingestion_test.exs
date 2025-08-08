defmodule IngestionTest do
  use ExUnit.Case
  doctest Ingestion

  test "greets the world" do
    assert Ingestion.hello() == :world
  end
end
