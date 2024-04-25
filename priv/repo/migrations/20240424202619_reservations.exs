defmodule EventsGrapAPI.Repo.Migrations.Reservations do
  use Ecto.Migration

  def change do
    create table("reservations") do
      add :user_id, references("users")
      add :event_id, references("events")
      add :status, :string, size: 50

      timestamps()
    end
  end
end
