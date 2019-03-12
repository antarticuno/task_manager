defmodule TaskManagerWeb.PageController do
  use TaskManagerWeb, :controller
  alias TaskManager.Assigns
  alias TaskManager.Users

  def index(conn, _params) do
    uid = get_session(conn, :user_id) || -1
    if uid >= 0 do
      assigns = Assigns.list_assigns_for_user(uid)
      user = Users.get_user(uid)
      manager = handle_manager(user)
      render(conn, "index.html", assigns_assignee: assigns, manager: manager)
    else
      render(conn, "index.html", assigns_assignee: [], manager: {})
    end
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
end
