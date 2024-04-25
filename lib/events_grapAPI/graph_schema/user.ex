defmodule EventsGrapAPI.GraphSchema.User do
  use Absinthe.Schema.Notation
  import_types(EventsGrapAPI.GraphSchema.{Reservation, Types})

  object :user do
    field :id, :id
    field :name, non_null(:string)
    field :email, non_null(:string)
    field :PasswordHash, non_null(:string)
    field :lastLogin, :datetime
    field :created_at, :datetime
    field :reservations, list_of(:reservation)

  end


    # alias EventsGrapAPI.Resolvers.Users, as: ResolverUser
  # query do
  #   field :users, list_of(:user) do
  #     resolve &ResolverUser.all/2
  #   end
  # end
end
