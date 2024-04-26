defmodule EventsGrapAPI.GraphSchema.Reservation do
  use Absinthe.Schema.Notation

  import_types(EventsGrapAPI.GraphSchema.Types, only: [:uct_datetime])

  object :reservation do
    field :id, non_null(:id)
    field :status, non_null(:string)
    field :user_id, :id
    field :event_id, :id
    field :created_at, :uct_datetime
    field :updated_at, :uct_datetime
  end
end
