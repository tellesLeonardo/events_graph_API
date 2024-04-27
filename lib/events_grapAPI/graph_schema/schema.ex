defmodule EventsGrapAPI.Schema do
  use Absinthe.Schema

  import_types(EventsGrapAPI.GraphSchema.{Types, Reservation, User, Event})

  query do
    import_fields(:user_query)
    import_fields(:event_query)
    import_fields(:reserv_query)
  end

  mutation do
    import_fields(:user_mutations)
    import_fields(:event_mutations)
    import_fields(:reserv_mutations)
  end
end
