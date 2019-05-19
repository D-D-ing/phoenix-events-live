defmodule PhoenixEventsLiveWeb.InteractionResolver do
  alias PhoenixEventsLive.Events

  def all_interactions(_root, _args, _info) do
    interactions = Events.list_interactions()
    {:ok, interactions}
  end

  def create_interaction(_root, args, _info) do
    case Events.create_interaction(args) do
      {:ok, interaction} ->
        {:ok, interaction}
      _error ->
        {:error, "could not create interaction"}
    end
  end
end