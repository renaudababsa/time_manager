defmodule ManagerVerify do
  import Logger
  import Plug.Conn
  require Joken.Signer
  require TimeManager.Token
  use TimeManagerWeb, :controller
  alias TimeManager.Account
  alias TimeManager.Account.User
  alias TimeManager.JwtAuthenticated
  alias TimeManager.Groups
  alias TimeManager.Groups.Group


  def init(opts), do: opts
  def call(conn, _opts) do
    # Logger.error "user_params: #{inspect(Groups.get_group!(Map.get(conn.assigns.claims, "group_id")).level)}"
    group_id = Groups.get_group!(Map.get(conn.assigns.claims, "group_id"))
    if (group_id != nil) do
      if (group_id.level >= 1) do
        conn
        |> put_status(:ok)
      else
        conn
        |> put_status(401)
        |> render(TimeManagerWeb.ErrorView, "error.json", reason: "not manager")
      end
    else
      conn
      |> put_status(401)
      |> render(TimeManagerWeb.ErrorView, "error.json", reason: "not manager")
    end
  end
end
