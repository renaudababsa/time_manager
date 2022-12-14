defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Account
  alias TimeManager.Account.User
  require Logger
  require Joken.Signer
  require TimeManager.Token
  # use Plug.Conn
  # use Phoenix.Token

  action_fallback TimeManagerWeb.FallbackController

  def getParam(conn, params) do
    username = Map.get(params, "username", nil)
    email = Map.get(params, "email", nil)
    # test email syntax




     if (username != nil || email != nil) do
      if (username != nil && email == nil) do
       user = Account.get_user_by_username(username)
       conn
       |> put_status(:ok)
       |> render("manyshow.json", users: user)
      end
      if (username == nil && email != nil) do
        user = Account.get_user_by_email(email)
        conn
        |> put_status(:ok)
        |> render("manyshow.json", users: user)
      end
      if (username != nil && email != nil) do
        user = Account.get_user_by_params(username, email)
        conn
        |> put_status(:ok)
        |> render("manyshow.json", users: user)
      end
     else
      user = Account.list_users()
        conn
        |> put_status(:ok)
        |> render("manyshow.json", users: user)
     end
  end

  def login(conn, params) do
    email = Map.get(params, "email", nil)
    password = Map.get(params, "password", nil)
    if (email != nil && password != nil) do
      tmp = Account.get_user_by_email(email)
      user = List.first(tmp)
      Logger.info("user: #{inspect(user)}")
      if (user != nil) do
        if (user.password == :crypto.hash(:sha256, [password, "iliamaaronflorianrenaud"])|> Base.encode16) do
          token = TimeManager.Token.generate_and_sign!(%{id: user.id, group_id: user.group_id, team_id: user.team_id}, Joken.Signer.parse_config(:rs256))
          # Logger.error "token: #{inspect(Joken.Signer.verify(token, Joken.Signer.parse_config(:rs256)))}"
          conn
          |> put_status(:ok)
          |> render("loginshow.json", user: user, token: token, csrf: Plug.CSRFProtection.get_csrf_token())
        else
          conn
          |> put_status(401)
          |> render(TimeManagerWeb.ErrorView, "error.json", reason: "wrong password or email")
        end
      else
        conn
        |> put_status(404)
        |> render(TimeManagerWeb.ErrorView, "error.json", reason: "wrong password or email")
      end
    else
      conn
      |> put_status(400)
      |> render(TimeManagerWeb.ErrorView, "error.json", reason: "wrong password or email")
    end
  end

  def create(conn, %{"user" => user_params}) do
    user_params = Map.put(user_params, "password", :crypto.hash(:sha256, [user_params["password"], "iliamaaronflorianrenaud"])|> Base.encode16)
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user, token: 0)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def getusersbyteam(conn, %{"team_id" => id}) do
    users = Account.get_users_by_team(id)
    render(conn, "manyshow.json", users: users)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    # Logger.error "user_params: #{inspect(Map.get(conn.assigns.claims, "id"))}"
    user_params = if (user_params["password"] != nil) do
      Map.put(user_params, "password", :crypto.hash(:sha256, [user_params["password"], "iliamaaronflorianrenaud"])|> Base.encode16)
    end
    user = Account.get_user!(id)
    with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Account.get_user!(id)

    with {:ok, %User{}} <- Account.delete_user(user) do
      render(conn, "show.json", user: user)
    end
  end
end
