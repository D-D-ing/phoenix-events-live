defmodule PhoenixEventsLive.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias PhoenixEventsLive.Repo

  alias PhoenixEventsLive.Events.Event

  @doc """
  Returns the list of events.

  ## Examples

      iex> list_events()
      [%Event{}, ...]

  """
  def list_events do
    Repo.all(Event)
  end

  def list_events_preloaded do
    Repo.all from p in Event, preload: [:interactions]
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id), do: Repo.get!(Event, id)


  @doc """
  Gets the single event referenced by the given accessToken.
  Interactions are preloaded in the returned event.

  ## Examples

    iex> get_event_by_access_token("fjdklasjfpdejkfikrnmapviurhafejeifiojeosoifj")
    %Event{}
  """
  def get_event_by_access_token(access_token) do
    Repo.get_by(Event, [access_token: access_token])
    |> Repo.preload(:interactions)
  end

  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{source: %Event{}}

  """
  def change_event(%Event{} = event) do
    Event.changeset(event, %{})
  end

  alias PhoenixEventsLive.Events.Interaction

  @doc """
  Returns the list of interactions.

  ## Examples

      iex> list_interactions()
      [%Interaction{}, ...]

  """
  def list_interactions do
    Repo.all(Interaction)
  end

  @doc """
  Gets a single interaction.

  Raises `Ecto.NoResultsError` if the Interaction does not exist.

  ## Examples

      iex> get_interaction!(123)
      %Interaction{}

      iex> get_interaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_interaction!(id), do: Repo.get!(Interaction, id)

  @doc """
  Creates a interaction.

  ## Examples

      iex> create_interaction(%{field: value})
      {:ok, %Interaction{}}

      iex> create_interaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_interaction(attrs \\ %{}) do
    %Interaction{}
    |> Interaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a interaction.

  ## Examples

      iex> update_interaction(interaction, %{field: new_value})
      {:ok, %Interaction{}}

      iex> update_interaction(interaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_interaction(%Interaction{} = interaction, attrs) do
    interaction
    |> Interaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Interaction.

  ## Examples

      iex> delete_interaction(interaction)
      {:ok, %Interaction{}}

      iex> delete_interaction(interaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_interaction(%Interaction{} = interaction) do
    Repo.delete(interaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking interaction changes.

  ## Examples

      iex> change_interaction(interaction)
      %Ecto.Changeset{source: %Interaction{}}

  """
  def change_interaction(%Interaction{} = interaction) do
    Interaction.changeset(interaction, %{})
  end
end
