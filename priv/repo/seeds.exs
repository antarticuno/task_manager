# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TaskManager.Repo.insert!(%TaskManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TaskManager.Repo
alias TaskManager.Users.User

Repo.insert!(%User{email: "example1@example.com", name: "Antartikun"})
Repo.insert!(%User{email: "example2@example.com", name: "Brenda"})
Repo.insert!(%Task{title: "HW06", description: "Create a task manager web application",
                   completed: false})
Repo.insert!(%Task{title: "HW05", description: "Finish the memory game", completed: true})
Repo.insert!(%Assign{taskmaster_id: 1, task_id: 1, time_spent: 8})
