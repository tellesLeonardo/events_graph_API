defmodule EventsGrapAPI.Repo do
  use Ecto.Repo,
    otp_app: :events_grapAPI,
    adapter: Ecto.Adapters.Postgres
end
