defmodule Core.Station.Projectors.ObservationProjector do
  use Commanded.Ecto.Projector,
    application: Core.App,
    repo: Core.Repo,
    name: "ObservationProjector"

  alias Core.Station.Events.ObservationRecorded
  alias Core.Station.ReadModels.Observation

  def project(%ObservationRecorded{} = event, _metadata) do
    %Observation{
      station_id: event.station_id,
      temperature: event.temperature,
      humidity: event.humidity,
      wind_speed: event.wind_speed,
      observed_at: event.observed_at
    }
    |> Ecto.Changeset.cast(%{}, &1, Map.keys(&1))
    |> Core.Repo.insert(on_conflict: :replace_all, conflict_target: :station_id)
  end
end
