defmodule TaskManager2Web.PageView do
  use TaskManager2Web, :view

  def is_manager?(user_id) do
    Enum.any?(TaskManager2.Users.list_users, &(&1.manager_id == user_id))
  end

end
