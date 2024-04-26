defmodule EventsGrapAPI.GraphSchema.Event do
  use Absinthe.Schema.Notation
  alias EventsGrapAPI.Service.Reservation, as: ServiceReservation

  import_types(EventsGrapAPI.GraphSchema.Reservation)

  object :event do
    field :id, :id
    field :name, :string
    field :description, :string
    field :location, :string
    field :capacity, non_null(:integer)
    field :event_date_time, :uct_datetime
    field :created_at, :uct_datetime

    field :reservations, list_of(:reservation) do
      resolve(&ServiceReservation.get_user_reservations/3)
    end
  end
end
