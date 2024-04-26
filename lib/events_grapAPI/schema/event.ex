defmodule EventsGrapAPI.Schema.Event do
  use Ecto.Schema
  import Ecto.Changeset

  alias EventsGrapAPI.Schema.Reservation

  @require_fields ~w(capacity)a

  @fields ~w(name
  description
  location
  event_date_time)a

  @type t :: %__MODULE__{}
  schema "events" do
    field(:name, :string)
    field(:description, :string)
    field(:location, :string)
    field(:event_date_time, :utc_datetime)
    field(:capacity, :integer)

    has_one(:reservation, Reservation)

    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, @fields ++ @require_fields)
    |> validate_required(@require_fields)
  end
end
