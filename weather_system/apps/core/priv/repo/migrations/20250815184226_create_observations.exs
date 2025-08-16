defmodule Core.Repo.Migrations.CreateObservations do
  use Ecto.Migration

  def change do
    create table(:observations) do
      add :station_id, :string, primary_key: true
      add :temperature, :float
      add :humidity, :float
      add :wind_speed, :float
      add :observed_at, :utc_datetime
      timestamps()
    end
  end
end
