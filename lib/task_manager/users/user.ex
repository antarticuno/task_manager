defmodule TaskManager.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string
    field :email, :string
    belongs_to :user, TaskManager.Users.User, foreign_key: :manager_id

    timestamps()

# TODO make sure this works
    has_many :assigns_assignee, TaskManager.Assigns.Assign, foreign_key: :taskmaster_id
    has_many :assigns_assigner, TaskManager.Assigns.Assign, foreign_key: :assigner_id
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :manager_id])
    |> validate_required([:email, :name])
    |> foreign_key_constraint(:manager_id)
  end
end
