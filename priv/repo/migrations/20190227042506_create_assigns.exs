defmodule TaskManager.Repo.Migrations.CreateAssigns do
  use Ecto.Migration

  def change do
    create table(:assigns) do
      add :time_spent, :integer, null: false
      add :taskmaster_id, references(:users, on_delete: :delete_all), null: false
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:assigns, [:taskmaster_id])
    create index(:assigns, [:task_id])
  end
end
