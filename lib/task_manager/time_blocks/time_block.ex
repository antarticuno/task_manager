defmodule TaskManager.TimeBlocks.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset


  schema "time_blocks" do
    field :end_time, :utc_datetime
    field :start_time, :utc_datetime
    belongs_to :assign, TaskManager.Assigns.Assign

    timestamps()
  end

  @doc false
  def changeset(time_block, attrs) do
    time_block
    |> cast(attrs, [:start_time, :end_time, :assign_id])
    |> validate_required([:start_time, :assign_id])
  end
end
