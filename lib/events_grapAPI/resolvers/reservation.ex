defmodule EventsGrapAPI.Resolvers.Reservation do
  alias EventsGrapAPI.Repo
  alias EventsGrapAPI.Schema.Reservation

  import Ecto.Query, only: [from: 2]

  def get_user_reservations(parent, _args, _context) do
    case Repo.all(from r in Reservation, where: r.user_id == ^parent.id) do
      nil -> {:ok, []}
      reservations -> {:ok, reservations}
    end
  end

  @spec create_multi_events(any(), any(), any()) :: :ok
  def create_multi_events(parent, args, context) do
    case Repo.transaction(fn ->
           Enum.map(args.event_id, fn evt ->
             case create(parent, Map.put(args, :event_id, evt), context) do
               {:ok, reservation} ->
                 reservation

               {:error, reason} ->
                 Repo.rollback("Failed to create reservation: #{inspect(reason)}")
             end
           end)
         end) do
      {:ok, reservations} ->
        {:ok, reservations}

      {:error, reason} ->
        {:error, "Transaction failed: #{inspect(reason)}"}
    end
  end

  def get_event_reservations(parent, _args, _context) do
    case Repo.get_by(Reservation, event_id: parent.id) do
      nil -> {:ok, []}
      reservations -> {:ok, reservations}
    end
  end

  def all(_parent, _args, _context) do
    {:ok, Repo.all(Reservation)}
  end

  def create(_parent, args, _context) do
    changeset = Reservation.changeset(%Reservation{}, args)

    case Repo.insert(changeset) do
      {:ok, reserv} -> {:ok, reserv}
      {:error, changeset} -> {:error, changeset}
    end
  end

  def update(_parent, args, _context) do
    case Repo.get(Reservation, args.id) do
      nil ->
        {:error, "Reservation not found"}

      reserv ->
        changeset = Reservation.changeset(reserv, args)

        case Repo.update(changeset) do
          {:ok, updated_reserv} -> {:ok, updated_reserv}
          {:error, changeset} -> {:error, changeset}
        end
    end
  end

  def delete(_parent, args, _context) do
    case Repo.get(Reservation, args.id) do
      nil ->
        {:error, "Reservation not found"}

      reserv ->
        case Repo.delete(reserv) do
          {:ok, _} -> {:ok, %{id: args.id}}
          {:error, reason} -> {:error, reason}
        end
    end
  end

  def get_occupied_capacity(parent, _args, _context) do
    case Repo.one(
           from re in Reservation,
             where: re.event_id == ^parent.id,
             select: count(re.id, :distinct)
         ) do
      nil -> {:ok, 0}
      number -> {:ok, number}
    end
  end
end
