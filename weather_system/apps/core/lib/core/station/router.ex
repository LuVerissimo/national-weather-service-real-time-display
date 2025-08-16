defmodule Core.Station.Router do
  use Commanded.Commands.Router

  alias Core.Station.Aggregate
  alias Core.Station.Commands.RecordObservation

  dispatch RecordObservation, to: Aggregate, identity: :station_id

end
