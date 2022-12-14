defmodule TimeManagerWeb.UserView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("loginshow.json", %{user: user, token: token, csrf: csrf }) do
    %{data: render_one(user, UserView, "user.json"), token: token, csrf: csrf}
  end

  def render("manyshow.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      group_id: user.group_id,
      team_id: user.team_id
    }
  end
end
