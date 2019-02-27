defmodule TaskManager.Assigns.Assign do
  use Ecto.Schema
  import Ecto.Changeset


  schema "assigns" do
    field :time_spent, :integer
    belongs_to :taskmaster, TaskManager.Users.User
    belongs_to :task, TaskManager.Tasks.Task

    timestamps()
  end

  @doc false
  def changeset(assign, attrs) do
    assign
    |> cast(attrs, [:time_spent, :taskmaster_id, :task_id])
    |> validate_required([:taskmaster_id, :task_id])
  end
end
