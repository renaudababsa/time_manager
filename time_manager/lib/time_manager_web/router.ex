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

  pipeline :checkjwt do
    plug :accepts, ["json"]
    plug CheckJWT
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api
    post "/users/login", UserController, :login
    post "/users", UserController, :create
    resources "/users", UserController, except: [:index, :new, :edit]
    resources "/groups", GroupController, only: [:show]

    scope "/workingtimes" do
      get "/:userID", WorkingTimeController, :getAll
      get "/:userID/:id", WorkingTimeController, :get
    end

    scope "/clocks" do
      get "/:userID", ClockController, :show
      post "/:userID", ClockController, :create
    end

  end

  scope "/api", TimeManagerWeb do
    pipe_through [:api, :jwtauthenticated, :managerverified, :checkjwt]
    scope "/users" do
      get "/teams/:team_id", UserController, :getusersbyteam
    end
  end

  scope "/api", TimeManagerWeb do
    pipe_through [:api, :jwtauthenticated, :adminverified, :checkjwt]
    resources "/teams", TeamsController, except: [:delete]
    delete "/teams/:id", TeamsController, :delete
    get "/users", UserController, :getParam
    post "/users", UserController, :create

    resources "/groups", GroupController, only: [:index, :create]

    scope "/workingtimes" do
      delete "/:userID/:id", WorkingTimeController, :delete
    end
    resources "/workingtimes", WorkingTimeController, only: [:show]
  end


  scope "/api", TimeManagerWeb do
    pipe_through [:api, :jwtauthenticated]
    scope "/workingtimes" do
      post "/:userID", WorkingTimeController, :create
      patch "/:userID/:id", WorkingTimeController, :update
    end
  end

end
