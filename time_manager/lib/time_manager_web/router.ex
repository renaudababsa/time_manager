defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api
    resources "/users", UserController, except: [:index, :new, :edit]
    get "/users", UserController, :getParam

    scope "/workingtimes" do
      get "/:userID", WorkingTimeController, :getAll
      post "/:userID", WorkingTimeController, :create
      get "/:userID/:id", WorkingTimeController, :get
    end
    resources "/workingtimes", WorkingTimeController, only: [:update, :delete, :show]

    scope "/clocks" do
      get "/:userID", ClockController, :show
      post "/:userID", ClockController, :create
    end
  end

end
