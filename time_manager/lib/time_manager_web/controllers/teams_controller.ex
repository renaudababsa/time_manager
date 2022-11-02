defmodule TimeManagerWeb.TeamsController do
  use TimeManagerWeb, :controller

  alias TimeManager.Team
  alias TimeManager.Team.Teams

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    teams = Team.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"teams" => teams_params}) do
    with {:ok, %Teams{} = teams} <- Team.create_teams(teams_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.teams_path(conn, :show, teams))
      |> render("show.json", teams: teams)
    end
  end

  def show(conn, %{"id" => id}) do
    teams = Team.get_teams!(id)
    render(conn, "show.json", teams: teams)
  end

  def update(conn, %{"id" => id, "teams" => teams_params}) do
    teams = Team.get_teams!(id)

    with {:ok, %Teams{} = teams} <- Team.update_teams(teams, teams_params) do
      render(conn, "show.json", teams: teams)
    end
  end

  def delete(conn, %{"id" => id}) do
    teams = Team.get_teams!(id)

    with {:ok, %Teams{}} <- Team.delete_teams(teams) do
      send_resp(conn, :no_content, "")
    end
  end
end
