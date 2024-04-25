defmodule EventsGrapAPI.Schema.Event do
  use Ecto.Schema
  import Ecto.Changeset

  alias EventsGrapAPI.Schema.Reservation

  @require_fields ~w(capacity)

  @fields ~w(name
  description
  location
  event_date_time)

  @type t :: %__MODULE__{}
  schema "events" do
    field(:name, :string)
    field(:description, :string)
    field(:location, :string)
    field(:event_date_time, :utc_datetime)
    field(:capacity, :integer)
    has_many :reservation, Reservation

    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, @fields)
    |> validate_required(@require_fields)
  end
end
