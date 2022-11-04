defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  # pipeline :jwt_authenticated do
  #   plug Guardian.AuthPipeline
  # end

  scope "/api", TimeManagerWeb do
    pipe_through :api
    resources "/users", UserController, except: [:index, :new, :edit]
    resources "/teams", TeamsController
    get "/users", UserController, :getParam
    post "/users", UserController, :create
    post "/users/login", UserController, :login

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
