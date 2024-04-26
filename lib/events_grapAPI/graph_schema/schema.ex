defmodule EventsGrapAPI.Schema.Hello do
  use Absinthe.Schema

  import_types(EventsGrapAPI.GraphSchema.{User, Event})

  query do
    import_fields(:user_query)
  end

  mutation do
    import_fields(:user_mutations)
  end
end
