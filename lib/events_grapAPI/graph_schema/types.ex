defmodule EventsGrapAPI.GraphSchema.Types do
  use Absinthe.Schema.Notation

  alias EventsGrapAPI.Resolvers.Reservation, as: RR
  alias EventsGrapAPI.Resolvers.Event, as: RE
  alias EventsGrapAPI.Resolvers.User, as: RU

  scalar :uct_datetime, description: "An ISO 8601 date and time" do
    serialize(&DateTime.to_iso8601/1)

    parse(fn
      %Absinthe.Blueprint.Input.String{value: value} ->
        case DateTime.from_iso8601(value) do
          {:ok, datetime, _} -> {:ok, datetime}
          _ -> :error
        end

      _ ->
        :error
    end)
  end

  object :reservation do
    field :id, non_null(:id)
    field :status, non_null(:string)
    field :user_id, :id
    field :event_id, :id
    field :created_at, :uct_datetime
    field :updated_at, :uct_datetime

    field :event, :event do
      resolve(&RE.get_event/3)
    end

    field :user, :user do
      resolve(&RU.get_user/3)
    end
  end

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

  object :event do
    field :id, :id
    field :name, :string
    field :description, :string
    field :location, :string
    field :capacity, non_null(:integer)
    field :event_date_time, :uct_datetime
    field :created_at, :uct_datetime

    field :occupied_capacity, :integer do
      resolve(&RR.get_occupied_capacity/3)
    end

    field :reservations, list_of(:reservation) do
      resolve(&RR.get_event_reservations/3)
    end
  end
end
