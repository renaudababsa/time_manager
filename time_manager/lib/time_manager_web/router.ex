defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TimeManagerWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit, :index]
    get "/users", UserController, :getByInfo , email: "XXX", username: "YYY"
    get "/workingtimes", WorkingTimeController, :getAll, start: "XXX", end: "YYY"
    scope "/workingtimes" do
      post "/:userID", WorkingTimeController, :create
      scope "/:userID" do
        get "/:id", WorkingTimeController, :get
      end
    end
    resources "/workingtimes", WorkingTimeController, only: [:update, :delete]
    scope "/clocks" do
      get "/:userID", ClockController, :show
      post "/:userID", ClockController, :create
    end
  end

end
