defmodule TaskManager2Web.UserController do
  use TaskManager2Web, :controller

  alias TaskManager2.Users
  alias TaskManager2.Users.User
  alias TaskManager2.Assigns

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.html", users: users)
  end

  def handle_manager(user) do
    mid = user.manager_id
    if (mid) do
      manager_employees = Users.get_manager_employees(mid)
      {Users.get_manager_name(mid), manager_employees, []}
    else 
      manager_employees = Users.get_manager_employees(user.id)
      employee_tasks = Assigns.list_assigns_for_manager(user.id)
      {"N/A", manager_employees, employee_tasks}
    end 
  end

  def new(conn, _params) do
    changeset = Users.change_user(%User{})
    managers = Users.list_managers()
    render(conn, "new.html", changeset: changeset, managers: managers)
  end

  def create(conn, %{"user" => user_params}) do
    case Users.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: Routes.page_path(conn, :index))
#TODO make this show the tasks for the user in tasks
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    changeset = Users.change_user(user)
    managers = Users.list_managers()
    render(conn, "edit.html", user: user, changeset: changeset, managers: managers)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    case Users.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    {:ok, _user} = Users.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end
end
