defmodule PhoenixEventsLiveWeb.Schema do
  use Absinthe.Schema
  import_types PhoenixEventsLiveWeb.Schema.Types

  alias PhoenixEventsLiveWeb.Resolvers.AccountResolver
  alias PhoenixEventsLiveWeb.Resolvers.EventResolver

  query do
    field :all_interactions, non_null(list_of(non_null(:interaction))) do
      resolve &EventResolver.all_interactions/3
    end

    field :all_events, non_null(list_of(non_null(:event))) do
      resolve &EventResolver.all_events/3
    end

    field :get_event_by_access_token, non_null(:event) do
      arg :access_token, non_null(:string)

      resolve &EventResolver.get_event_by_access_token/3
    end

    field :sign_in, :session do
      arg :username, non_null(:string)
      arg :password, non_null(:string)

      resolve &AccountResolver.login/3
    end

    field :my_user, :user do
      resolve &AccountResolver.my_user/3
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

      resolve &EventResolver.create_interaction/3
    end

    field :create_event, :event do
      arg :name, non_null(:string)
      arg :description, :string

      resolve &EventResolver.create_event/3
    end
  end

  subscription do
    field :event_created, :event do
      config fn _args, _info -> {:ok, topic: true} end
    end
  end
end