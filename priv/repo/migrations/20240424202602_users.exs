defmodule EventsGrapAPI.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table("users") do
      add :name, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :last_login, :timestamp

      timestamps()
    end
  end
end
