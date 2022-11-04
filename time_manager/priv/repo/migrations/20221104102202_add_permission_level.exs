defmodule TimeManager.Repo.Migrations.AddPermissionLevel do
  use Ecto.Migration

  def change do
    alter table(:groups) do
      add :level, :int, null: false, default: 0
    end
  end
end
