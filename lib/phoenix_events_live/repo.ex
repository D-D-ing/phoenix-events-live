defmodule PhoenixEventsLive.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_events_live,
    adapter: Ecto.Adapters.Postgres
end
