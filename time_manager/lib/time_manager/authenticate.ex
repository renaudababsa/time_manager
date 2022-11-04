defmodule Authenticate do
  #create a plug for the jwt token authentication whithout the guardian
  import Plug.Conn
  require Joken.Signer
  require TimeManager.Token
  require Logger
  use TimeManagerWeb, :controller
  alias TimeManager.Account
  alias TimeManager.Account.User
  alias TimeManager.JwtAuthenticated

  #get entry in a tuple


  def init(opts), do: opts
  def call(conn, _opts) do
    token = Enum.at(get_req_header(conn, "x-csrf-token"), 0)
    # Logger.error "conn: #{inspect(TimeManager.Token.verify_and_validate(token, Joken.Signer.parse_config(:rs256)))}"
    # Logger.error "conn: #{inspect(Enum.at(get_req_header(conn, "x-csrf-token"), 0))}"
    if (token != nil) do
      case TimeManager.Token.verify_and_validate(token, Joken.Signer.parse_config(:rs256)) do
        {:ok, claims} ->
          conn
          |> put_status(:ok)
          |> assign(:claims, claims)

        {:error, error} ->
          conn
          |> put_status(401)
          |> render(TimeManagerWeb.ErrorView, "error.json", reason: inspect error)

      end
    else
      conn
      |> put_status(401)
      |> render(TimeManagerWeb.ErrorView, "error.json", reason: "token not found")
    end
  end

end
