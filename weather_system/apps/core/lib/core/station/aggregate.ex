defmodule Core.Station.Aggregate do
  defstruct [
    :station_id,
    :temperature,
    :humidity,
    :wind_speed,
    :observed_at,
    :last_observation
  ]
  alias Core.Station.Commands.RecordObservation
  alias Core.Station.Events.ObservationRecorded

  def execute(%__MODULE__{station_id: nil}, %RecordObservation{} = cmd) do
    %ObservationRecorded{
      station_id: cmd.station_id,
      temperature: cmd.temperature,
      humidity: cmd.humidity,
      wind_speed: cmd.wind_speed,
      observed_at: cmd.observed_at
    }
  end

  def execute(%__MODULE__{station_id: _}, %RecordObservation{} = cmd) do
    %ObservationRecorded{
      station_id: cmd.station_id,
      temperature: cmd.temperature,
      humidity: cmd.humidity,
      wind_speed: cmd.wind_speed,
      observed_at: cmd.observed_at
    }
  end

  def apply(%__MODULE__{} = state, %ObservationRecorded{} = event) do
    %__MODULE__{
      state
      | station_id: event.station_id,
        temperature: event.temperature,
        humidity: event.humidity,
        wind_speed: event.wind_speed,
        observed_at: event.observed_at
    }
  end
end
