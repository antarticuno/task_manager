defmodule TaskManagerWeb.PageController do
  use TaskManagerWeb, :controller
  alias TaskManager.Assigns
  alias TaskManager.Users
  alias TaskManagerWeb.UserController

  def index(conn, _params) do
    uid = get_session(conn, :user_id) || -1
    if uid >= 0 do
      assigns = Assigns.list_assigns_for_user(uid)
      user = Users.get_user(uid)
      manager = UserController.handle_manager(user)
      time_blocks = TaskManager.TimeBlocks.list_time_blocks()
      render(conn, "index.html", assigns_assignee: assigns, manager: manager, time_blocks: time_blocks)
    else
      render(conn, "index.html", assigns_assignee: [], manager: {})
    end
  end

end
