defmodule PhoenixEventsLiveWeb.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: PhoenixEventsLive.Repo

  object :interaction do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :type, non_null(:integer)
    field :text, :string
    field :value, :string
    field :visible, :boolean
    field :items, list_of(non_null(:string))
    field :event_id, non_null(:id)
  end

  object :event do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :description, :string
    field :interactions, list_of(non_null(:interaction))
  end
end

