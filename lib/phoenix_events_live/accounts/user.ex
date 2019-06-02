defmodule PhoenixEventsLive.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :password_hash, :string
    field :token, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash, :token, :name, :email])
    |> validate_required([:username, :password_hash])
    |> unique_constraint(:username)
  end

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :password_confirmation, :email, :name, :token])
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = changeset) do
    Ecto.Changeset.change(changeset, password_hash: Comeonin.Bcrypt.hashpwsalt(pass))
  end
  defp put_pass_hash(other_changeset), do: other_changeset
end
