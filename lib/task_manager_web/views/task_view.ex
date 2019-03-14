defmodule TaskManager2Web.TaskView do
  use TaskManager2Web, :view

  alias TaskManager2Web.AssignView

  def assigned_users([]), do: "none"
  def assigned_users(assigns_list) do
    if (length(assigns_list) > 1) do
      Enum.fetch!(assigns_list, 0).user_assignee.name <> " +#{(length(assigns_list) - 1)}"
    else
      Enum.fetch!(assigns_list, 0).user_assignee.name
    end
  end

  def total_task_time(time_blocks, assigns) do
    Enum.reduce(assigns, 0, &(AssignView.total_time(time_blocks, &1.id) + &2))
  end

  def assigned?(uid, assigns) do
    Enum.any?(assigns, &(&1.taskmaster_id == uid))
  end

end
