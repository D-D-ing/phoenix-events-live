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

  pipeline :graphql do
    plug PhoenixEventsLiveWeb.Context
  end

  scope "/api" do
    pipe_through [:api, :graphql]

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: PhoenixEventsLiveWeb.Schema,
      socket: PhoenixEventsLiveWeb.UserSocket,
      interface: :simple
      # context: %{pubsub: PhoenixEventsLiveWeb.Endpoint}

    forward "/", Absinthe.Plug,
      schema: PhoenixEventsLiveWeb.Schema
  end

  scope "/", PhoenixEventsLiveWeb do
    pipe_through :browser

    get "/*path", PageController, :index
  end

end
