defmodule WebWeb.ObservationController do
  use WebWeb, :controller

  import Ecto.Query, only: [from: 2]

  alias Core.Repo
  alias Core.Station.ReadModels.Observation

  def index(conn, %{"station_id" => station_id}) do
    query =
      from(o in Observation,
        where: o.station_id == ^station_id
      )

    observations = Repo.all(query)

    json(conn, %{data: observations})
  end
end
