defmodule EventsGrapAPI.Resolvers.Reservation do
  alias EventsGrapAPI.Repo
  alias EventsGrapAPI.Schema.Reservation

  def get_user_reservations(parent, _args, _context) do
    case Repo.get_by(Reservation, user_id: parent.id) do
      nil -> {:ok, []}
      reservations -> {:ok, reservations}
    end
  end

  def get_event_reservations(parent, _args, _context) do
    case Repo.get_by(Reservation, event_id: parent.id) do
      nil -> {:ok, []}
      reservations -> {:ok, reservations}
    end
  end
end
