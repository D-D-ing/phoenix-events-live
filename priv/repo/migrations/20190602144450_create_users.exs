defmodule PhoenixEventsLive.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password_hash, :string
      add :token, :string
      add :name, :string
      add :email, :string

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
