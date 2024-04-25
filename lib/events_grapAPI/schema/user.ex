defmodule EventsGrapAPI.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias EventsGrapAPI.Schema.Reservation

  @require_fields ~w(
    name
    email
    PasswordHash
  )

  @fields ~w(lastLogin)

  @type t :: %__MODULE__{}
  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:PasswordHash, :string)
    field(:lastLogin, :utc_datetime)

    has_many :reservation, Reservation

    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, @fields)
    |> validate_required(@require_fields)
  end
end
