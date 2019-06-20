defmodule PhoenixEventsLive.LiveEvents.LiveEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "live_events" do
    field :access_token, :string
    field :description, :string
    field :name, :string

    has_many :interactions, PhoenixEventsLive.LiveEvents.Interaction

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
    |> put_access_token()
  end

  defp put_access_token(%Ecto.Changeset{valid?: true} = changeset) do
    # TODO: validate that the generated access_token is unique
    Ecto.Changeset.change(changeset, access_token: get_random_string(64))
  end
  defp put_access_token(other_changeset), do: other_changeset

  defp get_random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end
end
