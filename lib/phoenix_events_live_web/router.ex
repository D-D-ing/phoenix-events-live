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

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: PhoenixEventsLiveWeb.Schema,
      interface: :simple,
      context: %{pubsub: PhoenixEventsLiveWeb.Endpoint}
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
