defmodule PhoenixEventsLiveWeb.UserController do
  use PhoenixEventsLiveWeb, :controller

  alias PhoenixEventsLive.Accounts
  alias PhoenixEventsLive.Guardian

  action_fallback PhoenixEventsLiveWeb.FallbackController

  def show(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    render(conn, "user.json", user: user)
  end

  def sign_in_with_password(conn, %{"username" => username, "password" => password}) do
    case Accounts.jwt_sign_in_with_password(username, password) do
      {:ok, token, claims} ->
        {:ok, user} = Guardian.resource_from_claims(claims)
        conn |> render("jwt.json", %{jwt: token, user: user})
      _ ->
        {:error, :unauthorized}
    end
  end
end
