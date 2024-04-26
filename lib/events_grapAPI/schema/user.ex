defmodule EventsGrapAPI.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias EventsGrapAPI.Schema.Reservation

  @require_fields ~w(
    name
    email
    password_hash
  )a

  @fields ~w(last_login)a

  @type t :: %__MODULE__{}
  schema "users" do
    field(:name, :string)
    field(:email, :string)
    field(:password_hash, :string)
    field(:last_login, :utc_datetime)

    has_one(:reservation, Reservation)

    timestamps()
  end

  def changeset(user, params) do
    Map.merge(%{last_login: nil}, user)
    |> cast(params, @fields ++ @require_fields)
    |> put_change(:last_login, datetime())
    |> validate_required(@require_fields)
  end

  defp datetime do
    Timex.now()
    |> DateTime.truncate(:second)
  end
end
