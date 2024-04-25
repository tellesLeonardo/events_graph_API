defmodule EventsGrapAPI.Schema.Event do
  use Absinthe.Schema.Notation

  import_types(EventsGrapAPI.Schema.Reservation)

  object :event do
    field :id, :id
    field :name, :string
    field :description, :string
    field :location, :string
    field :capacity, non_null(:integer)
    field :event_date_time, :datetime
    field :created_at, :datetime
    field :reservations, list_of(:reservation)
  end
end
