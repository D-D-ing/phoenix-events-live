defmodule PhoenixEventsLiveWeb.Resolvers.AccountResolver do
  alias PhoenixEventsLive.Accounts

  def login(_root, %{username: username, password: password}, _info) do
    with {:ok, jwt, _} <- Accounts.jwt_sign_in_with_password(username, password) do
      {:ok, %{token: jwt}}
    end
  end

  def my_user(_root, _args, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def my_user(_root, _args, _info) do
    {:error, "unauthorized"}
  end
end