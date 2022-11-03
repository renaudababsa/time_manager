defmodule TimeManager.Repo.Migrations.Final do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :team_id,
      references(:teams, on_delete: :nothing),
      null: true,
      from: references(:teams, on_delete: :nothing)
      add :password, :string, null: false
    end
  end
end
