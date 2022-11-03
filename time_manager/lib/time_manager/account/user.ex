defmodule TimeManager.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :username, :string
    field :password, :string
    field :team_id, :id
    field :group_id, :id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :group_id, :team_id, :password])
    |> validate_required([:username, :email, :password])
  end
end
