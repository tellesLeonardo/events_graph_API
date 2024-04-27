defmodule EventsGrapAPI.GraphSchema.Reservation do
  use Absinthe.Schema.Notation

  alias EventsGrapAPI.Resolvers.Reservation, as: Resolver

  object :reserv_mutations do
    field :create_reserv, type: :reservation do
      arg(:status, :string)
      arg(:user_id, :id)
      arg(:event_id, :id)

      resolve(&Resolver.create/3)
    end

    field :update_reserv, type: :reservation do
      arg(:id, non_null(:id))
      arg(:status, :string)
      arg(:user_id, :id)
      arg(:event_id, :id)

      resolve(&Resolver.update/3)
    end

    field :delete_reserv, type: :reservation do
      arg(:id, non_null(:id))

      resolve(&Resolver.delete/3)
    end

    field :multi_reserv, type: list_of(:reservation) do
      arg(:status, :string)
      arg(:user_id, :id)
      arg(:event_id, list_of(:id))

      resolve(&Resolver.create_multi_events/3)
    end
  end

  object :reserv_query do
    field :reservs, list_of(:reservation) do
      resolve(&Resolver.all/3)
    end
  end
end
