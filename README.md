# TaskManager2

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

Task Manager

- Tasks
- Users

Users can have zero or more tasks, tasks can be assigned to 0 or more people.

Thus, have a table for users, tasks, and an assigns table. This was done to incorporate the notion of teams/
partners working on the same task. Tasks therefore contained the "completed" field and the assigns marked
the amount of time spent by the particular user on that task.

Users
+ username
+ name

Tasks
+ title
+ description
+ completed

Assigns
+ user_id
+ task_id
+ time_spent

Users are allowed to see the tasks, assignments, as well as their own tasks. I chose to remove any links
to User CRUD pages because I felt it was unnecessary for the functioning of a task tracker.

When Users login by provding just their email, the index page changes to show them the tasks that have been
assigned to them. This is a table that results from joining the assigns table and the tasks table. From here
users have links to edit the assigns row corresponding to the task they have been assigned so that they can
edit the amount of time spent. Users also have links to remove themselves from the assignment, as well as
to edit the task itself either to edit the title/description or to mark it as complete. Complete tasks
do not show up in the index page (note that the mytasks button in the nav links back to the home page
as well).

Additionally, on the home page, users have the option to create new assignments (linking to the assigns
new form) or to create new tasks (linking to the tasks new form). When a new task is created, one additional
button is provided to immediately assign the task to the user, if they choose to do so.

The Tasks index page indicates all of the available tasks, incorporating joined data from the Assigns and Users
tables to show the amount of time spent on a task, as well as whether it is assigned to anyone (and if so, who?). These columns are computed by grouping by the task. The minutes column is a summation of all of the assigns
time_spent fields. The assigned? column prints the name of the first person who was assigned the task, and then
the number of additional assignees.

When a user logs out, they are directed to the index page, where the tasks content has been replaced by
a link to create a new user.
