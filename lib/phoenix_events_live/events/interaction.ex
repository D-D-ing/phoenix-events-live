defmodule PhoenixEventsLive.Events.Interaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "interactions" do
    field :name, :string
    field :text, :string
    field :type, :integer
    field :value, :string
    field :visible, :boolean
    field :items, {:array, :string}
    belongs_to :event, PhoenixEventsLive.Events.Event, foreign_key: :event_id

    timestamps()
  end

  @doc false
  def changeset(interaction, attrs) do
    interaction
    |> cast(attrs, [:name, :type, :text, :value, :visible, :items, :event_id])
    |> validate_required([:name, :type, :event_id])
    |> foreign_key_constraint(:event_id)
  end
end
