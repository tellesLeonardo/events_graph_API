defmodule EventsGrapAPI.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name, :string, null: false
      add :email, :string, null: false
      add :PasswordHash, :string, null: false
      add :lastLogin, :timestamp

      timestamps()
    end
  end
end
