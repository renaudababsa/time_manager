defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  # pipeline :jwt_authenticated do
  #   plug Guardian.AuthPipeline
  # end

  #made a pipeline for the jwt token authentication whithout the guardian
  pipeline :jwtauthenticated do
    plug :accepts, ["json"]
    plug Authenticate
  end

  pipeline :isinteam do
    plug :accepts, ["json"]
    plug InTeam
  end

  pipeline :adminverified do
    plug :accepts, ["json"]
    plug AdminVerify
  end

  pipeline :managerverified do
    plug :accepts, ["json"]
    plug ManagerVerify
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api
    post "/users/login", UserController, :login
  end
  scope "/api", TimeManagerWeb do
    pipe_through [:api, :jwtauthenticated, :adminverified, :isinteam]
    resources "/users", UserController, except: [:index, :new, :edit, :show]
    resources "/teams", TeamsController
    get "/users", UserController, :getParam
    post "/users", UserController, :create
    get "/users/:team_id", UserController, :getusersbyteam

    resources "/groups", GroupController, only: [:create, :show]

    scope "/workingtimes" do
      get "/:userID", WorkingTimeController, :getAll
      post "/:userID", WorkingTimeController, :create
      get "/:userID/:id", WorkingTimeController, :get
      delete "/:userID/:id", WorkingTimeController, :delete
      put "/:userID/:id", WorkingTimeController, :update
    end
    resources "/workingtimes", WorkingTimeController, only: [:show]

    scope "/clocks" do
      get "/:userID", ClockController, :show
      post "/:userID", ClockController, :create
    end
  end

end
