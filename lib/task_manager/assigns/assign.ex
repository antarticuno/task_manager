defmodule TaskManager.Assigns.Assign do
  use Ecto.Schema
  import Ecto.Changeset


  schema "assigns" do
    field :time_spent, :integer
    belongs_to :user_assignee, TaskManager.Users.User, foreign_key: :taskmaster_id
    belongs_to :user_assigner, TaskManager.Users.User, foreign_key: :assigner_id
    belongs_to :task, TaskManager.Tasks.Task

    has_many :time_block, TaskManager.TimeBlocks.TimeBlock
    timestamps()
  end

  @doc false
  def changeset(assign, attrs) do
    assign
    |> cast(attrs, [:time_spent, :taskmaster_id, :task_id, :assigner_id])
    |> validate_required([:taskmaster_id, :task_id, :assigner_id])
    |> unique_constraint(:assigns_taskmaster_id_task_id_index)
  end
end
