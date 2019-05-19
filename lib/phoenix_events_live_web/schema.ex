defmodule PhoenixEventsLiveWeb.Schema do
  use Absinthe.Schema

  alias PhoenixEventsLiveWeb.InteractionResolver

  object :interaction do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :type, non_null(:integer)
    field :text, :string
    field :value, :string
    field :items, list_of(non_null(:string))
    field :event_id, non_null(:id)
  end


  query do
    field :all_interactions, non_null(list_of(non_null(:interaction))) do
      resolve &InteractionResolver.all_interactions/3
    end
  end

  mutation do
    field :create_interaction, :interaction do
      arg :name, non_null(:string)
      arg :type, non_null(:integer)
      arg :text, :string
      arg :value, :string
      arg :items, list_of(non_null(:string))
      arg :event_id, non_null(:id)

      resolve &InteractionResolver.create_interaction/3
    end
  end
end