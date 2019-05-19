defmodule PhoenixEventsLiveWeb.Resolvers.EventResolver do
  alias PhoenixEventsLive.Events

  def all_events(_root, _args, _info) do
    events = Events.list_events_preloaded()
    {:ok, events}
  end

  def get_event_by_access_token(_root, args, info) do
    case Events.get_event_by_access_token(args.access_token) do
      nil ->
        {:error, "event not found"}
      event ->
        {:ok, event}
    end
  end

  def create_event(_root, args, _info) do
    case Events.create_event(args) do
      {:ok, event} ->
        Absinthe.Subscription.publish(PhoenixEventsLiveWeb.Endpoint, event, event_created: true)
        {:ok, event}
      _error ->
        {:error, "could not create event"}
    end
  end

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