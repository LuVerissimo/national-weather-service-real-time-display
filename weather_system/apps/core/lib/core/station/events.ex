defmodule Core.Station.Events.ObservationRecorded do
  defstruct [:station_id, :temperature, :humidity, :wind_speed, :observed_at]
end
