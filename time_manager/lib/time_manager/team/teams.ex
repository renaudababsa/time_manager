defmodule TimeManager.Team.Teams do
  use Ecto.Schema
  import Ecto.Changeset

  schema "teams" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(teams, attrs) do
    teams
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
