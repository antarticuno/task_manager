defmodule TaskManager2.Assigns.Assign do
  use Ecto.Schema
  import Ecto.Changeset


  schema "assigns" do
    belongs_to :user_assignee, TaskManager2.Users.User, foreign_key: :taskmaster_id
    belongs_to :user_assigner, TaskManager2.Users.User, foreign_key: :assigner_id
    belongs_to :task, TaskManager2.Tasks.Task

    has_many :time_block, TaskManager2.TimeBlocks.TimeBlock
    timestamps()
  end

  @doc false
  def changeset(assign, attrs) do
    assign
    |> cast(attrs, [:taskmaster_id, :task_id, :assigner_id])
    |> validate_required([:taskmaster_id, :task_id, :assigner_id])
    |> unique_constraint(:assigns_taskmaster_id_task_id_index)
  end

end
