defmodule PhoenixEventsLiveWeb.Resolvers.LiveEventResolver do
  alias PhoenixEventsLive.LiveEvents

  def all_live_events(_root, _args, %{context: %{current_user: _current_user}}) do
    live_events = LiveEvents.list_live_events_preloaded()
    {:ok, live_events}
  end

  def all_live_events(_root, _args, _info) do
    {:error, "unauthorized"}
  end

  def get_live_event_by_access_token(_root, args, %{context: %{current_user: _current_user}}) do
    case LiveEvents.get_live_event_by_access_token(args.access_token) do
      nil ->
        {:error, "live_event not found"}
      live_event ->
        {:ok, live_event}
    end
  end

  def get_live_event_by_access_token(_root, _args, _info) do
    {:error, "unauthorized"}
  end

  def create_live_event(_root, args, %{context: %{current_user: _current_user}}) do
    case LiveEvents.create_live_event(args) do
      {:ok, live_event} ->
        Absinthe.Subscription.publish(PhoenixEventsLiveWeb.Endpoint, live_event, live_event_created: true)
        {:ok, live_event}
      _error ->
        {:error, "could not create live_event"}
    end
  end

  def create_live_event(_root, _args, _info) do
    {:error, "unauthorized"}
  end

  def all_interactions(_root, _args, %{context: %{current_user: _current_user}}) do
    interactions = LiveEvents.list_interactions()
    {:ok, interactions}
  end

  def all_interactions(_root, _args, _info) do
    {:error, "unauthorized"}
  end

  def create_interaction(_root, args, %{context: %{current_user: _current_user}}) do
    case LiveEvents.create_interaction(args) do
      {:ok, interaction} ->
        {:ok, interaction}
      _error ->
        {:error, "could not create interaction"}
    end
  end

  def create_interaction(_root, _args, _info) do
    {:error, "unauthorized"}
  end
end