defmodule TimeManager.APIFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.API` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2022-10-24 11:33:00]
      })
      |> TimeManager.API.create_clock()

    clock
  end

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        end: ~N[2022-10-24 11:35:00],
        start: ~N[2022-10-24 11:35:00]
      })
      |> TimeManager.API.create_working_time()

    working_time
  end
end
