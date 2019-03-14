defmodule TaskManager2Web.AssignView do
  use TaskManager2Web, :view

  def total_time(timeblocks, assign_id) do
    Enum.reduce(timeblocks, 0, &(if &1.assign_id == assign_id do time_difference(&1.start_time, &1.end_time) + &2 else &2 end))/(60)
    |> Float.round(3)
  end

  defp time_difference(starttime, endtime) do
    if (endtime) do
      max(DateTime.diff(endtime,  starttime), 0)
    else
      0
    end
  end

end
