defmodule PhoenixEventsLiveWeb.Schema do
  use Absinthe.Schema
  import_types PhoenixEventsLiveWeb.Schema.Types

  alias PhoenixEventsLiveWeb.Resolvers.AccountResolver
  alias PhoenixEventsLiveWeb.Resolvers.LiveEventResolver

  query do
    field :all_interactions, non_null(list_of(non_null(:interaction))) do
      resolve &LiveEventResolver.all_interactions/3
    end

    field :all_live_events, non_null(list_of(non_null(:live_event))) do
      resolve &LiveEventResolver.all_live_events/3
    end

    field :get_live_event_by_access_token, non_null(:live_event) do
      arg :access_token, non_null(:string)

      resolve &LiveEventResolver.get_live_event_by_access_token/3
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
      arg :live_event_id, non_null(:id)

      resolve &LiveEventResolver.create_interaction/3
    end

    field :create_live_event, :live_event do
      arg :name, non_null(:string)
      arg :description, :string

      resolve &LiveEventResolver.create_live_event/3
    end
  end

  subscription do
    field :live_event_created, :live_event do
      config fn _args, _info -> {:ok, topic: true} end
    end
  end
end