defmodule TaskManager.Repo.Migrations.CreateTimeBlocks do
  use Ecto.Migration

  def change do
    create table(:time_blocks) do
      add :start_time, :utc_datetime, null: false
      add :end_time, :utc_datetime
      add :assign_id, references(:assigns, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:time_blocks, [:assign_id])
  end
end
