defmodule PhoenixEventsLiveWeb.UserController do
  use PhoenixEventsLiveWeb, :controller

  alias PhoenixEventsLive.Accounts
  alias PhoenixEventsLive.Accounts.User

  action_fallback PhoenixEventsLiveWeb.FallbackController

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.json", user: user)
  end

end
