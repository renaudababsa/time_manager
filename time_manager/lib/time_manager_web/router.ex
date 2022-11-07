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
#a
  scope "/api", TimeManagerWeb do
    pipe_through :api
    post "/users/login", UserController, :login
    post "/users", UserController, :create
  end

  scope "/api", TimeManagerWeb do
    pipe_through [:api, :jwtauthenticated, :adminverified, :isinteam]
    resources "/users", UserController, except: [:index, :new, :edit, :show]
    resources "/teams", TeamsController
    get "/users", UserController, :getParam
    post "/users", UserController, :create
    get "/users/:team_id", UserController, :getusersbyteam

    resources "/groups", GroupController, only: [:index, :create, :show]

    scope "/workingtimes" do
      post "/:userID", WorkingTimeController, :create
      delete "/:userID/:id", WorkingTimeController, :delete
      put "/:userID/:id", WorkingTimeController, :update
    end
    resources "/workingtimes", WorkingTimeController, only: [:show]
  end

end
