defmodule PhoenixEventsLive.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :description, :string
      add :access_token, :string

      timestamps()
    end

  end
end
