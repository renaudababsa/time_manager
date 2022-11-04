defmodule GroupVerify do
  import Logger
  import Plug.Conn
  require Joken.Signer
  require TimeManager.Token
  use TimeManagerWeb, :controller
  alias TimeManager.Account
  alias TimeManager.Account.User
  alias TimeManager.JwtAuthenticated


  def init(opts), do: opts
  def call(conn, _opts) do

  end
end
