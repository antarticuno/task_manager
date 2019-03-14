defmodule TaskManager2.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string, null: false
      add :description, :string
      add :completed, :boolean, default: false, null: false

      timestamps()
    end

  end
end
