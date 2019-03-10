defmodule TaskManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false
      add :manager_id, references(:users, on_delete: :nothing), default: nil

      timestamps()
    end

    create unique_index(:users, [:email])
    # create index(:assigns, [:taskmaster_id])
    # create index(:assigns, [:assigner_id])

  end
end
