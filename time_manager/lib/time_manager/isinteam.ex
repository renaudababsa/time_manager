defmodule InTeam do
import Logger
import Plug.Conn
require Joken.Signer
require TimeManager.Token
use TimeManagerWeb, :controller
alias TimeManager.Account
alias TimeManager.Account.User
alias TimeManager.JwtAuthenticated
alias TimeManager.Team
alias TimeManager.Team.Teams
alias TimeManager.Groups
alias TimeManager.Groups.Group


def init(opts), do: opts
def call(conn, _opts) do
  team = Team.get_teams!(Map.get(conn.assigns.claims, "team_id"))
  admin = Groups.get_group!(Map.get(conn.assigns.claims, "group_id"))
  Logger.error "user_params: #{inspect(conn.params["team_id"])}"

  if (team != nil) do
    if (team.id == conn.params["team_id"] || admin.level == 3) do
      conn
      |> put_status(:ok)
    else
      conn
      |> put_status(401)
      |> render(TimeManagerWeb.ErrorView, "error.json", reason: "not admin")
    end
  else
    conn
    |> put_status(401)
    |> render(TimeManagerWeb.ErrorView, "error.json", reason: "not admin")
  end
end
end
