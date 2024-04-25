defmodule EventsGrapAPI.Repo.Migrations.Events do
  use Ecto.Migration

  def change do
    create table("events") do
      add :name, :string
      add :description, :text
      add :location, :text
      add :event_date_time, :timestamp
      add :capacity, :integer, null: false

      timestamps()
    end
  end
end
