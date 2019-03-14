defmodule TaskManagerWeb.PageView do
  use TaskManagerWeb, :view

  def is_manager?(user_id) do
    Enum.any?(TaskManager.Users.list_users, &(&1.manager_id == user_id))
  end

end
