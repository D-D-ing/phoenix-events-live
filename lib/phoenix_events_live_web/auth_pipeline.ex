defmodule PhoenixEventsLive.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :phoenix_events_live,
  module: PhoenixEventsLive.Guardian,
  error_handler: PhoenixEventsLive.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end