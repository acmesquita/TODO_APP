defmodule TodoAppWeb.Router do
  use TodoAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TodoAppWeb.Plug.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TodoAppWeb do
    pipe_through :browser
    
    get "/", TarefaController, :index

    # post "/", TarefaController, :create
    # get "/new", TarefaController, :new
    # get "/:id/edit", TarefaController, :edit
    # put "/:id", TarefaController, :update
    # delete "/:id", TarefaController, :delete

    resources "/", TarefaController
  end

  scope "/auth", TodoAppWeb do
    pipe_through :browser

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    get "/:provider/logout", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", TodoAppWeb do
  #   pipe_through :api
  # end
end
