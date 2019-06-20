defmodule PhoenixEventsLive.Repo.Migrations.CreateInteractions do
  use Ecto.Migration

  def change do
    create table(:interactions) do
      add :name, :string
      add :type, :integer
      add :text, :string
      add :value, :string
      add :visible, :boolean, default: :false
      add :items, {:array, :string}
      add :live_event_id, references(:live_events, on_delete: :nothing)

      timestamps()
    end

    create index(:interactions, [:live_event_id])
  end
end
