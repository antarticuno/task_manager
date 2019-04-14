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
- Assigns
- Time Blocks

Users can have zero or more tasks, tasks can be assigned to 0 or more people. Additionally, users can work on their
assignments in zero or more intervals of time (time blocks).

Thus, have a table for users, tasks, assigns, and time blocks. This was done to incorporate the notion of teams/
partners working on the same task. Tasks therefore contained the "completed" field and the assigns who assigned the task to who.
Time blocks used to mark the amount of time spent by a particular user on a task.

Users
+ username
+ name
+ manager_id

Tasks
+ title
+ description
+ completed

Assigns
+ taskmaster_id
+ assigner_id
+ task_id

Time_Blocks
+ user_id
+ assign_id
+ start_time
+ end_time

Visitors to the page will not be able to access any of the forms to edit data without logging in first. The one exception
is the create user page which is permitted should the user wish to create an account. Nonetheless, visitors can still
view all of the tasks, as well as the assignments that are in progress.

Users are allowed to see the tasks, uncompleted assignments, as well as their own tasks. I chose to remove any links
to User CRUD pages because I felt it was unnecessary for the functioning of a task tracker.

When Users login by provding just their email, the index page changes to show them the tasks that have been
assigned to them. This is a table that results from joining the assigns table and the tasks table. 
Additionally, users can see their manager (N/A if the user is a manager), and their peers. Managers can also
see a table summarizing the work performed on tasks within their organization (manager + underlings). From here
users have links to edit time blocks corresponding to their assigned task so that they can
edit/add the amount of time spent. Users also have links to remove themselves from the assignment. Complete tasks
do not show up in the index page (note that the mytasks button in the nav links back to the home page
as well).

Additionally, on the home page, managers have the option to create new assignments (linking to the assigns
new form) or to create new tasks (linking to the tasks new form).

The Tasks index page indicates all of the available tasks, incorporating joined data from the Assigns and Users
tables to show the amount of time spent on a task, as well as whether it is assigned to anyone (and if so, who?). These columns are computed by grouping by the task. The minutes column is a summation of all of the time blocks corresponding to an assign
for that task. The assigned? column prints the name of the first person who was assigned the task, and then
the number of additional assignees.

When a user logs out, they are directed to the index page, where the tasks content has been replaced by
a link to create a new user.

-- Version 2 Additions --
Time blocks were introduced in version 2, which are a composition of start time and end time in UTC_datetime.
A button is provided to log time (to start and then close the time block on sequential clicks).

NOTE: in this version, users must stay on the page to be able to close the time block by clicking the button on assigns/
It is still possible to edit the time block after the fact, but the timestamp must be manually provided.
Additionally, only the end_time is editable at this time.

When a manager is directed to create a new assignment, the available users to assign to is prefiltered to only members of the
manager's organization (1 level deep). Furthermore, attempts to create assignments in which non-managers are the assigner will fail.

-- Version 3 Additions --
Time blocks now display as the server's local time rather than as UTC datetime.

Invalid end times (i.e. an end time before a start time) are rejected updates on the front end.

Users can now make themselves managers from the create user page.

Managers have the ability to edit other users (at this time, they can edit other managers as well, including updating their roles unfortunately).
