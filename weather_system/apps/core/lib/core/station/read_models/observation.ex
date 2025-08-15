defmodule Core.Station.ReadModel.Observation do
  use Ecto.Schema

  @primary_key {:station_id, :string, autogenerate: false}
  schema "observations" do
    field :temperature, :float
    field :humidity, :float
    field :wind_speed, :float
    field :observed_at, :utc_datetime
  end
end
