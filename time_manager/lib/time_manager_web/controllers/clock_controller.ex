defmodule TimeManagerWeb.ClockController do
  use TimeManagerWeb, :controller
  alias TimeManager.API
  alias TimeManager.API.Clock

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    clocks = API.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, %{"userID" => user_id, "clock" => clock_params}) do
    # add user_id to clock_params
    clock_params = Map.put(clock_params, "user", user_id)
    with {:ok, %Clock{} = clock} <- API.create_clock(clock_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"userID" => user}) do
    clock = API.get_clock_by_user(user)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = API.get_clock!(id)

    with {:ok, %Clock{} = clock} <- API.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = API.get_clock!(id)

    with {:ok, %Clock{}} <- API.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
