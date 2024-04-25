defmodule EventsGrapAPI.Schema.Reservation do
  use Absinthe.Schema.Notation

  import_types(EventsGrapAPI.Schema.User, EventsGrapAPI.Schema.Event)

  object :event do
    field :status, non_null(:string)
    field :user_id, :user
    field :event_id, :event
    field :created_at, :datetime
    field :updated_at, :datetime
  end
end