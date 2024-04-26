defmodule EventsGrapAPI.Schema.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  alias EventsGrapAPI.Schema.{User, Event}

  @fields ~w(status
  user_id
  event_id)a

  @type t :: %__MODULE__{}
  schema "reservations" do
    field(:status, :string)

    belongs_to :event, Event
    belongs_to :user, User

    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:status, max: 50)
  end
end
