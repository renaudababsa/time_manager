defmodule TimeManager.Groups.Group do
  use Ecto.Schema
  import Ecto.Changeset

  schema "groups" do
    field :name, :string
    field :level, :integer

    timestamps()
  end

  @doc false
  def changeset(group, attrs) do
    group
    |> cast(attrs, [:name, :level])
    |> validate_required([:name])
  end
end
