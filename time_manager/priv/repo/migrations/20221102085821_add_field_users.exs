defmodule TimeManager.Repo.Migrations.AddFieldUsers do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :group_id, references(:groups, on_delete: :nothing), null: false
      add :team_id, references(:teams, on_delete: :nothing), null: false
    end
    create index(:users, [:group_id])
    create index(:users, [:team_id])
  end
end
