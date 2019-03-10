defmodule TaskManagerWeb.TaskView do
  use TaskManagerWeb, :view

  def assigned_users([]), do: "none"
  def assigned_users(assigns_list) do
    if (length(assigns_list) > 1) do
      Enum.fetch!(assigns_list, 0).user_assignee.name <> " +#{(length(assigns_list) - 1)}"
    else
      Enum.fetch!(assigns_list, 0).user_assignee.name
    end
  end

  def total_time(assigns_list) do
    Enum.reduce(assigns_list, 0, &(&1.time_spent + &2))
  end

end
