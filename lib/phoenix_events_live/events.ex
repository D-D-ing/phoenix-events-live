defmodule PhoenixEventsLive.LiveEvents do
  @moduledoc """
  The LiveEvents context.
  """

  import Ecto.Query, warn: false
  alias PhoenixEventsLive.Repo

  alias PhoenixEventsLive.LiveEvents.LiveEvent
  alias PhoenixEventsLive.LiveEvents.Interaction

  @doc """
  Returns the list of live_events.

  ## Examples

      iex> list_live_events()
      [%LiveEvent{}, ...]

  """
  def list_live_events do
    Repo.all(LiveEvent)
  end

  def list_live_events_preloaded do
    Repo.all from p in LiveEvent, preload: [:interactions]
  end

  @doc """
  Gets a single live_event.

  Raises `Ecto.NoResultsError` if the LiveEvent does not exist.

  ## Examples

      iex> get_live_event!(123)
      %LiveEvent{}

      iex> get_live_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_live_event!(id), do: Repo.get!(LiveEvent, id)


  @doc """
  Gets the single LiveEvent referenced by the given accessToken.
  Interactions are preloaded in the returned LiveEvent.

  ## Examples

    iex> get_live_event_by_access_token("fjdklasjfpdejkfikrnmapviurhafejeifiojeosoifj")
    %LiveEvent{}
  """
  def get_live_event_by_access_token(access_token) do
    Repo.get_by(LiveEvent, [access_token: access_token])
    |> Repo.preload(:interactions)
  end

  @doc """
  Creates a LiveEvent.

  ## Examples

      iex> create_live_event(%{field: value})
      {:ok, %LiveEvent{}}

      iex> create_live_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_live_event(attrs \\ %{}) do
    %LiveEvent{}
    |> LiveEvent.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a LiveEvent.

  ## Examples

      iex> update_live_event(live_event, %{field: new_value})
      {:ok, %LiveEvent{}}

      iex> update_live_event(live_event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_live_event(%LiveEvent{} = live_event, attrs) do
    live_event
    |> LiveEvent.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a LiveEvent.

  ## Examples

      iex> delete_live_event(live_event)
      {:ok, %LiveEvent{}}

      iex> delete_live_event(live_event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_live_event(%LiveEvent{} = live_event) do
    Repo.delete(live_event)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking LiveEvent changes.

  ## Examples

      iex> change_live_event(live_event)
      %Ecto.Changeset{source: %LiveEvent{}}

  """
  def change_live_event(%LiveEvent{} = live_event) do
    LiveEvent.changeset(live_event, %{})
  end


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
