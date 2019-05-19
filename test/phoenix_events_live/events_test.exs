defmodule PhoenixEventsLive.EventsTest do
  use PhoenixEventsLive.DataCase

  alias PhoenixEventsLive.Events

  describe "events" do
    alias PhoenixEventsLive.Events.Event

    @valid_attrs %{accessToken: "some accessToken", description: "some description", name: "some name"}
    @update_attrs %{accessToken: "some updated accessToken", description: "some updated description", name: "some updated name"}
    @invalid_attrs %{accessToken: nil, description: nil, name: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Events.create_event(@valid_attrs)
      assert event.accessToken == "some accessToken"
      assert event.description == "some description"
      assert event.name == "some name"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, %Event{} = event} = Events.update_event(event, @update_attrs)
      assert event.accessToken == "some updated accessToken"
      assert event.description == "some updated description"
      assert event.name == "some updated name"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end

  describe "interactions" do
    alias PhoenixEventsLive.Events.Interaction

    @valid_attrs %{name: "some name", text: "some text", type: 42, value: "some value"}
    @update_attrs %{name: "some updated name", text: "some updated text", type: 43, value: "some updated value"}
    @invalid_attrs %{name: nil, text: nil, type: nil, value: nil}

    def interaction_fixture(attrs \\ %{}) do
      {:ok, interaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_interaction()

      interaction
    end

    test "list_interactions/0 returns all interactions" do
      interaction = interaction_fixture()
      assert Events.list_interactions() == [interaction]
    end

    test "get_interaction!/1 returns the interaction with given id" do
      interaction = interaction_fixture()
      assert Events.get_interaction!(interaction.id) == interaction
    end

    test "create_interaction/1 with valid data creates a interaction" do
      assert {:ok, %Interaction{} = interaction} = Events.create_interaction(@valid_attrs)
      assert interaction.name == "some name"
      assert interaction.text == "some text"
      assert interaction.type == 42
      assert interaction.value == "some value"
    end

    test "create_interaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_interaction(@invalid_attrs)
    end

    test "update_interaction/2 with valid data updates the interaction" do
      interaction = interaction_fixture()
      assert {:ok, %Interaction{} = interaction} = Events.update_interaction(interaction, @update_attrs)
      assert interaction.name == "some updated name"
      assert interaction.text == "some updated text"
      assert interaction.type == 43
      assert interaction.value == "some updated value"
    end

    test "update_interaction/2 with invalid data returns error changeset" do
      interaction = interaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_interaction(interaction, @invalid_attrs)
      assert interaction == Events.get_interaction!(interaction.id)
    end

    test "delete_interaction/1 deletes the interaction" do
      interaction = interaction_fixture()
      assert {:ok, %Interaction{}} = Events.delete_interaction(interaction)
      assert_raise Ecto.NoResultsError, fn -> Events.get_interaction!(interaction.id) end
    end

    test "change_interaction/1 returns a interaction changeset" do
      interaction = interaction_fixture()
      assert %Ecto.Changeset{} = Events.change_interaction(interaction)
    end
  end
end
