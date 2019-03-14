defmodule TaskManager2Web.AssignController do
  use TaskManager2Web, :controller

  alias TaskManager2.Assigns
  alias TaskManager2.Assigns.Assign
  alias TaskManager2.TimeBlocks
  alias TaskManager2.TimeBlocks.TimeBlock

  def index(conn, _params) do
    assigns = Assigns.list_assigns()
    time_blocks = TimeBlocks.list_time_blocks()
    render(conn, "index.html", assigns: assigns, time_blocks: time_blocks)
  end

  def new(conn, _params) do
    users = TaskManager2.Users.list_users_organization(get_session(conn, :user_id))
    changeset = Assigns.change_assign(%Assign{})
    tasks = TaskManager2.Tasks.list_tasks()
    render(conn, "new.html", changeset: changeset, users: users, tasks: tasks)
  end

  def create(conn, %{"assign" => assign_params}) do
    case Assigns.create_assign(assign_params) do
      {:ok, assign} ->
        conn
        |> put_flash(:info, "Assign created successfully.")
        |> redirect(to: Routes.assign_path(conn, :show, assign))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    assign = Assigns.get_assign(id)
    timeblocks = TimeBlocks.list_time_blocks_for_assign(id)
    # timeblocks = TimeBlocks.list_time_blocks
    render(conn, "show.html", assign: assign, timeblocks: timeblocks)
  end

  def edit(conn, %{"id" => id}) do
    assign = Assigns.get_assign(id)
    users = TaskManager2.Users.list_users()
    tasks = TaskManager2.Tasks.list_tasks()
    changeset = Assigns.change_assign(assign)
    render(conn, "edit.html", assign: assign, changeset: changeset, users: users, tasks: tasks)
  end

  def update(conn, %{"id" => id, "assign" => assign_params}) do
    assign = Assigns.get_assign(id)

    case Assigns.update_assign(assign, assign_params) do
      {:ok, assign} ->
        conn
        |> put_flash(:info, "Assign updated successfully.")
        |> redirect(to: Routes.assign_path(conn, :show, assign))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", assign: assign, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    assign = Assigns.get_assign(id)
    {:ok, _assign} = Assigns.delete_assign(assign)

    conn
    |> put_flash(:info, "Assign deleted successfully.")
    |> redirect(to: Routes.assign_path(conn, :index))
  end
end
