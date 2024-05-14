mix deps.get
mix ecto.drop
mix ecto.setup
exec mix phx.server
