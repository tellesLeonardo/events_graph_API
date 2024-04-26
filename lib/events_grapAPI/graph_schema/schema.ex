defmodule EventsGrapAPI.Schema do
  use Absinthe.Schema

  import_types(EventsGrapAPI.GraphSchema.Reservation)
  import_types(EventsGrapAPI.GraphSchema.{User, Event})

  query do
    import_fields(:user_query)
    import_fields(:event_query)
  end

  mutation do
    import_fields(:user_mutations)
    import_fields(:event_mutations)
  end
end
