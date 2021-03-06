defmodule TaskManager2.Assigns do
  @moduledoc """
  The Assigns context.
  """

  import Ecto.Query, warn: false
  alias TaskManager2.Repo

  alias TaskManager2.Assigns.Assign

  @doc """
  Returns the list of assigns.

  ## Examples

      iex> list_assigns()
      [%Assign{}, ...]

  """
  def list_assigns do
    Repo.all from a in Assign,
      preload: [:user_assignee, :task]
  end

  def list_assigns_for_user(uid) do
    Repo.all from a in Assign,
      where: a.taskmaster_id == ^uid,
      preload: [:user_assignee, :task]
  end

  def list_assigns_for_manager(mid) do
    Repo.all from a in Assign,
      where: a.assigner_id == ^mid,
      preload: [:user_assignee, :task, :user_assigner]
  end

  @doc """
  Gets a single assign.

  Raises `Ecto.NoResultsError` if the Assign does not exist.

  ## Examples

      iex> get_assign!(123)
      %Assign{}

      iex> get_assign!(456)
      ** (Ecto.NoResultsError)

  """
  def get_assign!(id), do: Repo.get!(Assign, id)

  def get_assign(id) do
    Repo.one from a in Assign,
      where: a.id == ^id,
      preload: [:user_assignee, :task, :user_assigner]
  end

  defp validate_manager_assigned(attrs) do
    {taskmaster_id, _} = Integer.parse(attrs["taskmaster_id"])
    {assigner_id, _} = Integer.parse(attrs["assigner_id"])
    taskmaster = TaskManager2.Users.get_user(taskmaster_id) || %TaskManager2.Users.User{manager_id: -1}
    taskmaster.manager_id == assigner_id || (is_nil(taskmaster.manager_id) && taskmaster_id == assigner_id)
  end

  @doc """
  Creates a assign.

  ## Examples

      iex> create_assign(%{field: value})
      {:ok, %Assign{}}

      iex> create_assign(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_assign(attrs \\ %{}) do
    if validate_manager_assigned(attrs) do
      %Assign{}
      |> Assign.changeset(attrs)
      |> Repo.insert()
    else
      raise ArgumentError, message: "Create: only managers can assign"
    end
  end

  @doc """
  Updates a assign.

  ## Examples

      iex> update_assign(assign, %{field: new_value})
      {:ok, %Assign{}}

      iex> update_assign(assign, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_assign(%Assign{} = assign, attrs) do
    if validate_manager_assigned(attrs) do
      assign
      |> Assign.changeset(attrs)
      |> Repo.update()
    else 
      raise ArgumentError, message: "Update: only managers can assign"
    end
  end

  @doc """
  Deletes a Assign.

  ## Examples

      iex> delete_assign(assign)
      {:ok, %Assign{}}

      iex> delete_assign(assign)
      {:error, %Ecto.Changeset{}}

  """
  def delete_assign(%Assign{} = assign) do
    Repo.delete(assign)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking assign changes.

  ## Examples

      iex> change_assign(assign)
      %Ecto.Changeset{source: %Assign{}}

  """
  def change_assign(%Assign{} = assign) do
    Assign.changeset(assign, %{})
  end
end
