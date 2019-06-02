# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoenix_events_live,
  ecto_repos: [PhoenixEventsLive.Repo]

# Configures the endpoint
config :phoenix_events_live, PhoenixEventsLiveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Q3TrJ2Wifhy09fC7whzcNV8OPGs/xX+RFQWpFtNdctZzgA35cIRyArRRRadf6MMr",
  render_errors: [view: PhoenixEventsLiveWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixEventsLive.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cors_plug,
  origin: ["http://localhost:3000", "http://localhost:4000"],
  max_age: 86400,
  methods: ["GET", "POST"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
