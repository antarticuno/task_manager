defmodule TaskManager.Users.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string
    field :email, :string

    timestamps()

# TODO make sure this works
    has_many :assigns, TaskManager.Assigns.Assign 
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
  end
end
