defmodule EventsGrapAPI.Schema.User do
  use Absinthe.Schema.Notation

  import_types(EventsGrapAPI.Schema.Reservation)

  object :user do
    field :id, :id

    field :name, non_null(:string)
    field :name, non_null(:string)
    field :name, non_null(:string)
    field :lastLogin, :datetime
    field :created_at, :datetime
    field :reservations, list_of(:reservation)
  end
end
