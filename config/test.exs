use Mix.Config

# Configure your database
config :phoenix_events_live, PhoenixEventsLive.Repo,
  username: "postgres",
  password: "postgres",
  database: "phoenix_events_live_test",
  hostname: "localhost",
  port: 65432,
  pool: Ecto.Adapters.SQL.Sandbox

# Guardian config
config :phoenix_events_live, PhoenixEventsLive.Guardian,
       issuer: "dding_conference_app",
       secret_key: "ltt+A2RvGId6QPyhCbzmoHbOFrMDLgJRS+rSRla5ihWjLdo5XUp9P39PZubVF+9i"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_events_live, PhoenixEventsLiveWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
