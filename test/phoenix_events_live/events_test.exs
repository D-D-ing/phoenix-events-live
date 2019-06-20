defmodule PhoenixEventsLive.LiveEventsTest do
  use PhoenixEventsLive.DataCase

  alias PhoenixEventsLive.LiveEvents

  describe "live_events" do
    alias PhoenixEventsLive.LiveEvents.LiveEvent

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{accessToken: nil, description: nil, name: nil}

    def live_event_fixture(attrs \\ %{}) do
      {:ok, live_event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> LiveEvents.create_live_event()

      live_event
    end

    test "list_live_events/0 returns all live_events" do
      live_event = live_event_fixture()
      assert LiveEvents.list_live_events() == [live_event]
    end

    test "get_live_event!/1 returns the live_event with given id" do
      live_event = live_event_fixture()
      assert LiveEvents.get_live_event!(live_event.id) == live_event
    end

    test "create_live_event/1 with valid data creates a live_event" do
      assert {:ok, %LiveEvent{} = live_event} = LiveEvents.create_live_event(@valid_attrs)
      assert live_event.description == "some description"
      assert live_event.name == "some name"
    end

    test "create_live_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LiveEvents.create_live_event(@invalid_attrs)
    end

    test "update_live_event/2 with valid data updates the live_event" do
      live_event = live_event_fixture()
      assert {:ok, %LiveEvent{} = live_event} = LiveEvents.update_live_event(live_event, @update_attrs)
      assert live_event.description == "some updated description"
      assert live_event.name == "some updated name"
      assert String.length(live_event.access_token) == 64
    end

    test "update_live_event/2 with invalid data returns error changeset" do
      live_event = live_event_fixture()
      assert {:error, %Ecto.Changeset{}} = LiveEvents.update_live_event(live_event, @invalid_attrs)
      assert live_event == LiveEvents.get_live_event!(live_event.id)
    end

    test "delete_live_event/1 deletes the live_event" do
      live_event = live_event_fixture()
      assert {:ok, %LiveEvent{}} = LiveEvents.delete_live_event(live_event)
      assert_raise Ecto.NoResultsError, fn -> LiveEvents.get_live_event!(live_event.id) end
    end

    test "change_live_event/1 returns a live_event changeset" do
      live_event = live_event_fixture()
      assert %Ecto.Changeset{} = LiveEvents.change_live_event(live_event)
    end

    test "get_live_event_by_access_token/1 for an existing live_event" do
      live_event =
        live_event_fixture()
        |> Repo.preload(:interactions)
      fetched_live_event = LiveEvents.get_live_event_by_access_token(live_event.access_token)
      assert live_event == fetched_live_event
    end

    test "get_live_event_by_access_token/1 for not existing live_event" do
      assert nil == LiveEvents.get_live_event_by_access_token("invalid_token")
    end
  end

  describe "interactions" do
    alias PhoenixEventsLive.LiveEvents.Interaction

    @valid_attrs %{name: "some name", text: "some text", type: 42, value: "some value", visible: :false}
    @update_attrs %{name: "some updated name", text: "some updated text", type: 43, value: "some updated value"}
    @invalid_attrs %{name: nil, text: nil, type: nil, value: nil}

    def interaction_fixture(attrs \\ %{}) do
      live_event = insert_live_event()
      {:ok, interaction} =
        attrs
        |> Enum.into(Map.merge(%{live_event_id: live_event.id}, @valid_attrs))
        |> LiveEvents.create_interaction()

      interaction
    end

    test "list_interactions/0 returns all interactions" do
      interaction = interaction_fixture()
      assert LiveEvents.list_interactions() == [interaction]
    end

    test "get_interaction!/1 returns the interaction with given id" do
      interaction = interaction_fixture()
      assert LiveEvents.get_interaction!(interaction.id) == interaction
    end

    test "create_interaction/1 with valid data creates a interaction" do
      live_event = insert_live_event()
      attr = Map.merge(%{live_event_id: live_event.id}, @valid_attrs)
      assert {:ok, %Interaction{} = interaction} = LiveEvents.create_interaction(attr)
      assert interaction.name == "some name"
      assert interaction.text == "some text"
      assert interaction.type == 42
      assert interaction.value == "some value"
    end

    test "create_interaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = LiveEvents.create_interaction(@invalid_attrs)
    end

    test "update_interaction/2 with valid data updates the interaction" do
      interaction = interaction_fixture()
      assert {:ok, %Interaction{} = interaction} = LiveEvents.update_interaction(interaction, @update_attrs)
      assert interaction.name == "some updated name"
      assert interaction.text == "some updated text"
      assert interaction.type == 43
      assert interaction.value == "some updated value"
    end

    test "update_interaction/2 with invalid data returns error changeset" do
      interaction = interaction_fixture()
      assert {:error, %Ecto.Changeset{}} = LiveEvents.update_interaction(interaction, @invalid_attrs)
      assert interaction == LiveEvents.get_interaction!(interaction.id)
    end

    test "delete_interaction/1 deletes the interaction" do
      interaction = interaction_fixture()
      assert {:ok, %Interaction{}} = LiveEvents.delete_interaction(interaction)
      assert_raise Ecto.NoResultsError, fn -> LiveEvents.get_interaction!(interaction.id) end
    end

    test "change_interaction/1 returns a interaction changeset" do
      interaction = interaction_fixture()
      assert %Ecto.Changeset{} = LiveEvents.change_interaction(interaction)
    end
  end
end
