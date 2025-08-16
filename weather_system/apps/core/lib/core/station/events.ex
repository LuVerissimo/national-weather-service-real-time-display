defmodule Core.Station.Events.ObservationRecorded do
  @derive Jason.Encoder
  defstruct [:station_id, :temperature, :humidity, :wind_speed, :observed_at]
end
