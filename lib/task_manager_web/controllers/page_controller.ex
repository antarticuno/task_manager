defmodule TaskManager2Web.PageController do
  use TaskManager2Web, :controller
  alias TaskManager2.Assigns
  alias TaskManager2.Users
  alias TaskManager2Web.UserController

  def index(conn, _params) do
    uid = get_session(conn, :user_id) || -1
    if uid >= 0 do
      assigns = Assigns.list_assigns_for_user(uid)
      user = Users.get_user(uid)
      manager = UserController.handle_manager(user)
      time_blocks = TaskManager2.TimeBlocks.list_time_blocks()
      render(conn, "index.html", assigns_assignee: assigns, manager: manager, time_blocks: time_blocks)
    else
      render(conn, "index.html", assigns_assignee: [], manager: {})
    end
  end

end
