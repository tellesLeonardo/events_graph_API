defmodule EventsGrapAPI.Schema.Reservation do
  use Ecto.Schema
  import Ecto.Changeset

  alias EventsGrapAPI.Schema.{User, Event}

  @fields ~w(status
  user_id
  event_id)

  @type t :: %__MODULE__{}
  schema "events" do
    field(:status, :string)
    has_one(:event, Event)
    has_one(:user, User)

    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:status, max: 50)
  end
end
