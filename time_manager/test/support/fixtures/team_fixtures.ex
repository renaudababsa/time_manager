defmodule TimeManager.TeamFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Team` context.
  """

  @doc """
  Generate a teams.
  """
  def teams_fixture(attrs \\ %{}) do
    {:ok, teams} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TimeManager.Team.create_teams()

    teams
  end
end
