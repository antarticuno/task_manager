defmodule TaskManager2.Repo do
  use Ecto.Repo,
    otp_app: :task_manager,
    adapter: Ecto.Adapters.Postgres
end
