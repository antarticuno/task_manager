defmodule TaskManager.Assigns do
  @moduledoc """
  The Assigns context.
  """

  import Ecto.Query, warn: false
  alias TaskManager.Repo

  alias TaskManager.Assigns.Assign

  @doc """
  Returns the list of assigns.

  ## Examples

      iex> list_assigns()
      [%Assign{}, ...]

  """
  def list_assigns do
    Repo.all(Assign)
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

  @doc """
  Creates a assign.

  ## Examples

      iex> create_assign(%{field: value})
      {:ok, %Assign{}}

      iex> create_assign(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_assign(attrs \\ %{}) do
    %Assign{}
    |> Assign.changeset(attrs)
    |> Repo.insert()
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
    assign
    |> Assign.changeset(attrs)
    |> Repo.update()
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
