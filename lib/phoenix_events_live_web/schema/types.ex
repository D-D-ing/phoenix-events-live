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
    field :live_event_id, non_null(:id)
  end

  object :live_event do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :description, :string
    field :access_token, :string
    field :interactions, list_of(non_null(:interaction))
  end

  object :session do
    field :token, :string
  end

  object :user do
    field :name, :string
    field :username, non_null(:string)
    field :token, :string
    field :email, :string
  end
end

