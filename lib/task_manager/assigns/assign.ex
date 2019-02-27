defmodule TaskManager.Assigns.Assign do
  use Ecto.Schema
  import Ecto.Changeset


  schema "assigns" do
    field :time_spent, :integer
    field :taskmaster_id, :id
    field :task_id, :id

    timestamps()
  end

  @doc false
  def changeset(assign, attrs) do
    assign
    |> cast(attrs, [:time_spent])
    |> validate_required([:time_spent])
  end
end
