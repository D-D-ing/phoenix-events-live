defmodule PhoenixEventsLive.Repo.Migrations.CreateLiveEvents do
  use Ecto.Migration

  def change do
    create table(:live_events) do
      add :name, :string
      add :description, :string
      add :access_token, :string

      timestamps()
    end

  end
end
