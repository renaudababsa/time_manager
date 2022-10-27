defmodule TimeManagerWeb.WorkingTimeController do
  use TimeManagerWeb, :controller

  alias TimeManager.API
  alias TimeManager.API.WorkingTime

  action_fallback TimeManagerWeb.FallbackController

  def create(conn, %{"userID" => user_id, "working_time" => working_time_params}) do
    working_time_params = Map.put(working_time_params, "user", user_id)
    with {:ok, %WorkingTime{} = working_time} <- API.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def get(conn, %{"userID" => user_id, "id" => id}) do
    working_time = API.get_working_time(id)
    render(conn, "show.json", working_time: working_time)
  end

  def getAll(conn, params) do
    user_id = Map.get(params, "userID", nil)
    startDate = Map.get(params, "start", nil)
    endDate = Map.get(params, "end", nil)
    if (user_id != nil && startDate != nil && endDate != nil) do
      working_times = API.get_working_time_range(user_id, startDate, endDate)
      render(conn, "manyshow.json", working_times: working_times)
    else
      workingtimes = API.list_workingtimes()
      render(conn, "index.json", workingtimes: workingtimes)
    end
  end

  def show(conn, %{"id" => id}) do
    working_time = API.get_working_time(id)
    render(conn, "show.json", working_time: working_time)
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = API.get_working_time(id)

    with {:ok, %WorkingTime{} = working_time} <- API.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = API.get_working_time(id)

    with {:ok, %WorkingTime{}} <- API.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end
end
