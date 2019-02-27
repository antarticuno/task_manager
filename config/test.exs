use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :task_manager, TaskManagerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :task_manager, TaskManager.Repo,
  username: "task_manager",
  password: "task_manager",
  database: "task_manager_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
