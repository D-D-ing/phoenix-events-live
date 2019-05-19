defmodule PhoenixEventsLive.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  schema "events" do
    field :accessToken, :string
    field :description, :string
    field :name, :string

    has_many :interactions, PhoenixEventsLive.Events.Interaction

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :description, :accessToken])
    |> validate_required([:name, :description, :accessToken])
  end
end
