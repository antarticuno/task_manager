defmodule TaskManagerWeb.PageController do
  use TaskManagerWeb, :controller
  alias TaskManager.Assigns

  def index(conn, _params) do
    uid = get_session(conn, :user_id) || -1
    assigns = Assigns.list_assigns_for_user(uid)
    render(conn, "index.html", assigns: assigns)
  end
end
