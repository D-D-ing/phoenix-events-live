defmodule PhoenixEventsLiveWeb.Context do
  @behaviour Plug

  import Plug.Conn
  import Ecto.Query, only: [where: 2]

  alias PhoenixEventsLive.Guardian

  alias PhoenixEventsLive.Repo
  alias PhoenixEventsLive.Accounts.User

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} ->
       put_private(conn, :absinthe, %{context: context})
      _ ->
       conn
    end
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user} <- authorize(token) do
      {:ok, %{current_user: user, token: token}}
    end
  end

  defp authorize(token) do
    case Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        Guardian.resource_from_claims(claims)
      error ->
        error
    end
  end
 end