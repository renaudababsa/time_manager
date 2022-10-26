defmodule TimeManager.APIFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.API` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> TimeManager.API.create_user()

    user
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2022-10-24 11:23:00]
      })
      |> TimeManager.API.create_clock()

    clock
  end
end
