defmodule TaskManager2Web.Router do
  use TaskManager2Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug TaskManager2Web.Plugs.FetchSession
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :ajax do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_flash
    plug TaskManager2Web.Plugs.FetchSession
  end

  scope "/", TaskManager2Web do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController
    resources "/tasks", TaskController
    resources "/assigns", AssignController
    resources "/sessions", SessionController, only: [:create, :delete], singleton: true
  end

  scope "/ajax/", TaskManager2Web do
    resources "/time_blocks", TimeBlockController, except: [:new, :edit]
  end

  # Other scopes may use custom stacks.
  # scope "/api", TaskManager2Web do
  #   pipe_through :api
  # end
end
