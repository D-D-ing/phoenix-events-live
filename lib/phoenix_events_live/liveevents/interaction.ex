defmodule PhoenixEventsLive.LiveEvents.Interaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "interactions" do
    field :name, :string
    field :text, :string
    field :type, :integer
    field :value, :string
    field :visible, :boolean
    field :items, {:array, :string}
    belongs_to :event, PhoenixEventsLive.LiveEvents.LiveEvent, foreign_key: :live_event_id

    timestamps()
  end

  @doc false
  def changeset(interaction, attrs) do
    interaction
    |> cast(attrs, [:name, :type, :text, :value, :visible, :items, :live_event_id])
    |> validate_required([:name, :type, :live_event_id])
    |> foreign_key_constraint(:live_event_id)
  end
end
