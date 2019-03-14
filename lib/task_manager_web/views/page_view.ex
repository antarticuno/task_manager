defmodule TaskManager2Web.PageView do
  use TaskManager2Web, :view

  def is_manager?(user_id) do
    user = TaskManager2.Users.get_user(user_id) || %TaskManager2.Users.User{manager_id: -1}
    is_nil user.manager_id
  end

end
