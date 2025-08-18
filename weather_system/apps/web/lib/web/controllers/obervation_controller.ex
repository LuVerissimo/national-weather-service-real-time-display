defmodule Web.ObservationController do
  use Web, :controller

  alias Core.Repo
  alias Core.Station.ReadModels.Observation

  def show(conn, %{"id" => station_id}) do
    case Repo.get(Observation, station_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Not found"})

      observation ->
        json(conn, %{data: observation})
    end
  end
end
