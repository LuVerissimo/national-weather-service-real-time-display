defmodule Core.Station.ReadModels.Observation do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:station_id, :string, autogenerate: false}
  @derive {Jason.Encoder,
           only: [
             :station_id,
             :temperature,
             :humidity,
             :wind_speed,
             :observed_at,
             :inserted_at,
             :updated_at
           ]}
  schema "observations" do
    field(:temperature, :float)
    field(:humidity, :float)
    field(:wind_speed, :float)
    field(:observed_at, :utc_datetime)

    timestamps()
  end

  def changeset(observation, attrs) do
    observation
    |> cast(attrs, [:station_id, :temperature, :humidity, :wind_speed, :observed_at])
    |> validate_required([:station_id, :temperature, :humidity, :wind_speed, :observed_at])
  end
end
