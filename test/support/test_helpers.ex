defmodule PhoenixEventsLive.TestHelpers do
  alias PhoenixEventsLive.Repo

  def insert_live_event(attrs \\ %{}) do
    changes = Map.merge(%{
      name: "Some Name",
      description: "desc#{Base.encode16(:crypto.strong_rand_bytes(8))}",
      id: 0,
    }, Map.new(attrs))

    %PhoenixEventsLive.LiveEvents.LiveEvent{}
    |> PhoenixEventsLive.LiveEvents.LiveEvent.changeset(changes)
    |> Repo.insert!()
  end
end