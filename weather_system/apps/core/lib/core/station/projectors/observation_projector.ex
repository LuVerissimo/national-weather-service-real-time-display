defmodule Core.Station.Projectors.ObservationProjector do
  use Commanded.Projections.Ecto,
    application: Core.App,
    repo: Core.Repo,
    name: "ObservationProjector"

  alias Core.Station.Events.ObservationRecorded
  alias Core.Station.ReadModels.Observation

  def project(%ObservationRecorded{} = event, _metadata) do
    attrs = %{
      station_id: event.station_id,
      temperature: event.temperature,
      humidity: event.humidity,
      wind_speed: event.wind_speed,
      observed_at: event.observed_at
    }

    changeset =
      %Observation{}
      |> Ecto.Changeset.cast(attrs, Map.keys(attrs))
      |> Ecto.Changeset.validate_required(Map.keys(attrs))

    case Core.Repo.insert(changeset, on_conflict: :replace_all, conflict_target: :station_id) do
      {:ok, observation} ->
        Phoenix.PubSub.broadcast(Web.PubSub, "weather_updates", {:new_observation, observation})

      {:error, changeset} ->
        IO.inspect(changeset.errors, label: "Failed to insert observation")
    end
  end
end
