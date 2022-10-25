defmodule TimeManagerWeb.WorkingTimeView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.WorkingTimeView

  def render("index.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingTimeView, "working_time.json")}
  end

  def render("show.json", %{working_time: working_time}) do
    %{data: render_one(working_time, WorkingTimeView, "working_time.json")}
  end

  def render("manyshow.json", %{working_time: working_time}) do
    %{data: render_many(working_time, WorkingTimeView, "working_time.json")}
  end

  def render("working_time.json", %{working_time: working_time}) do
    %{
      id: working_time.id,
      start: working_time.start,
      user: working_time.user,
      end: working_time.end
    }
  end
end
