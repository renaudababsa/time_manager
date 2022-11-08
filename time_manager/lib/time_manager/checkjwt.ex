defmodule CheckJWT do
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
    conn
    |>put_status(:ok)
  end
  end
