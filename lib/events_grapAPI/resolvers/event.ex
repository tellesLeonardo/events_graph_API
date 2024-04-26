defmodule EventsGrapAPI.Resolvers.Event do
  alias EventsGrapAPI.Repo
  alias EventsGrapAPI.Schema.Event

  def all(_parent, _args, _context) do
    {:ok, Repo.all(Event)}
  end

  def create(_parent, args, _context) do
    case DateTime.from_iso8601("#{args.event_date_time}") do
      {:ok, event_date_time, _} ->
        args = Map.put(args, :event_date_time, event_date_time)
        changeset = Event.changeset(%Event{capacity: 0}, args)

        case Repo.insert(changeset) do
          {:ok, event} -> {:ok, event}
          {:error, changeset} -> {:error, changeset}
        end

      {:error, _} ->
        {:error, "Invalid datetime format"}
    end
  end

  def update(_parent, args, _context) do
    case Repo.get(Event, args.id) do
      nil ->
        {:error, "Event not found"}

      event ->
        changeset = Event.changeset(event, args)

        case Repo.update(changeset) do
          {:ok, updated_event} -> {:ok, updated_event}
          {:error, changeset} -> {:error, changeset}
        end
    end
  end

  def delete(_parent, args, _context) do
    case Repo.get(Event, args.id) do
      nil ->
        {:error, "Event not found"}

      event ->
        case Repo.delete(event) do
          {:ok, _} -> {:ok, %{id: args.id}}
          {:error, reason} -> {:error, reason}
        end
    end
  end
end
