defmodule PhoenixEventsLive.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :token, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash, :token, :name, :email])
    |> validate_required([:username, :password_hash])
    |> unique_constraint(:username)
  end

end
