defmodule Core.Station.Commands.RecordObservation do
  defstruct [:station_id, :temperature, :humidity, :wind_speed, :observed_at]
end
