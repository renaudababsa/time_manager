defmodule TimeManagerWeb.UserController do
  use TimeManagerWeb, :controller

  alias TimeManager.Account
  alias TimeManager.Account.User

  action_fallback TimeManagerWeb.FallbackController

  def getParam(conn, params) do
    username = Map.get(params, "username", nil)
    email = Map.get(params, "email", nil)
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
      conn
      |> put_status(500)
     end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Account.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Account.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Account.get_user!(id)

    with {:ok, %User{} = user} <- Account.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Account.get_user!(id)

    with {:ok, %User{}} <- Account.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
