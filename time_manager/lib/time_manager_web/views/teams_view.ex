defmodule TimeManagerWeb.TeamsView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.TeamsView

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, TeamsView, "teams.json")}
  end

  def render("show.json", %{teams: teams}) do
    %{data: render_one(teams, TeamsView, "teams.json")}
  end

  def render("message.json", %{reason: reason}) do
    %{message: reason}
  end

  def render("teams.json", %{teams: teams}) do
    %{
      id: teams.id,
      name: teams.name
    }
  end
end
