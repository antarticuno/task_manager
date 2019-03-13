defmodule TaskManagerWeb.AssignView do
  use TaskManagerWeb, :view

  def total_time(timeblocks) do
    Enum.reduce(timeblocks, 0, &(time_difference(&1.start_time, &1.end_time) + &2))/(60)
  end

  defp time_difference(starttime, endtime) do
    if (endtime) do
      max(DateTime.diff(endtime,  starttime), 0)
    else
      0
    end
  end

end
