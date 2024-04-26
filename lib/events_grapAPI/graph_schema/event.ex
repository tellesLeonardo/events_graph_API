defmodule EventsGrapAPI.GraphSchema.Event do
  use Absinthe.Schema.Notation
  alias EventsGrapAPI.Resolvers.Reservation, as: RR
  alias EventsGrapAPI.Resolvers.Event, as: ResolverEvent

  object :event do
    field :id, :id
    field :name, :string
    field :description, :string
    field :location, :string
    field :capacity, non_null(:integer)
    field :event_date_time, :uct_datetime
    field :created_at, :uct_datetime

    field :reservations, list_of(:reservation) do
      resolve(&RR.get_event_reservations/3)
    end
  end

  object :event_mutations do
    field :create_event, type: :event do
      arg(:name, :string)
      arg(:description, :string)
      arg(:location, :string)
      arg(:capacity, non_null(:integer))
      arg(:event_date_time, :uct_datetime)
      arg(:created_at, :uct_datetime)

      resolve(&ResolverEvent.create/3)
    end

    field :update_event, type: :event do
      arg(:id, non_null(:id))
      arg(:name, :string)
      arg(:description, :string)
      arg(:location, :string)
      arg(:capacity, non_null(:integer))
      arg(:event_date_time, :uct_datetime)
      arg(:created_at, :uct_datetime)

      resolve(&ResolverEvent.update/3)
    end

    field :delete_event, type: :event do
      arg(:id, non_null(:id))

      resolve(&ResolverEvent.delete/3)
    end
  end

  object :event_query do
    field :events, list_of(:event) do
      resolve(&ResolverEvent.all/3)
    end
  end
end
