defmodule PhoenixEventsLiveWeb.Router do
  use PhoenixEventsLiveWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug PhoenixEventsLive.Guardian.AuthPipeline
  end

  pipeline :graphql do
    plug PhoenixEventsLiveWeb.Context
  end

  scope "/api/graphql" do
    pipe_through [:api, :graphql]

    forward "/dev", Absinthe.Plug.GraphiQL,
      schema: PhoenixEventsLiveWeb.Schema,
      socket: PhoenixEventsLiveWeb.UserSocket,
      interface: :simple
      # context: %{pubsub: PhoenixEventsLiveWeb.Endpoint}

    forward "/", Absinthe.Plug,
      schema: PhoenixEventsLiveWeb.Schema
  end

  scope "/api/rest", PhoenixEventsLiveWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/my_user", UserController, :show
  end

  scope "/api/rest", PhoenixEventsLiveWeb do
    pipe_through :api

    post "/sign_in_with_password", UserController, :sign_in_with_password
  end

  scope "/", PhoenixEventsLiveWeb do
    pipe_through :browser

    get "/*path", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixEventsLiveWeb do
  #   pipe_through :api
  # end
end
