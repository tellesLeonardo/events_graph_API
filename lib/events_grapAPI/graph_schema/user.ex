defmodule EventsGrapAPI.GraphSchema.User do
  use Absinthe.Schema.Notation

  alias EventsGrapAPI.Resolvers.Reservation, as: RR
  alias EventsGrapAPI.Resolvers.User, as: ResolverUser

  object :user do
    field :id, :id
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :password_hash, non_null(:string)
    field :last_login, :uct_datetime
    field :created_at, :uct_datetime

    field :reservations, list_of(:reservation) do
      resolve(&RR.get_user_reservations/3)
    end
  end

  object :user_mutations do
    field :create_user, type: :user do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password_hash, non_null(:string))

      resolve(&ResolverUser.create/3)
    end

    field :update_user, type: :user do
      arg(:id, non_null(:id))
      arg(:name, :string)
      arg(:email, :string)

      resolve(&ResolverUser.update/3)
    end

    field :delete_user, type: :user do
      arg(:id, non_null(:id))

      resolve(&ResolverUser.delete/3)
    end
  end

  object :user_query do
    field :users, list_of(:user) do
      resolve(&ResolverUser.all/3)
    end
  end
end
