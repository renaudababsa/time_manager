defmodule TimeManager.Repo.Migrations.UserEmail do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :email, :string, null: false, unique: true
    end
  end
end
