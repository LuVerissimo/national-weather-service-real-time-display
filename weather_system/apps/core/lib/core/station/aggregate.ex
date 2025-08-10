defmodule Core.Station.Aggregate do

  defstruct [
  :station_id,
  :temperature,
  :humidity,
  :wind_speed,
  :observed_at,
  :last_observation,
  ]

  def execute(%{station_id: nil}, %Core.Station.Commands.RecordObservation{} = cmd) do
    %Core.Station.Commands.RecordObservation{
      station_id: cmd.station_id,
      temperature: cmd.temperature,
      humidity: cmd.humidity,
      wind_speed: cmd.wind_speed,
      observed_at: cmd.observed_at
    }
  end

  def execute(%{station_id: _}, %Core.Station.Commands.RecordObservation{} = cmd) do
    %Core.Station.Commands.RecordObservation{
      station_id: cmd.station_id,
      temperature: cmd.temperature,
      humidity: cmd.humidity,
      wind_speed: cmd.wind_speed,
      observed_at: cmd.observed_at
    }
  end

  def apply(%__MODULE__{} = state, %Core.Station.Events.ObservationRecorded{} = event) do
    %__MODULE__{
      state | station_id: event.station_id,
      temperature: event.temperature,
      humidity: event.humidity,
      wind_speed: event.wind_speed,
      observed_at: event.observed_at
    }
  end
end
