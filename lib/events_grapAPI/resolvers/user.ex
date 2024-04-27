defmodule EventsGrapAPI.Resolvers.User do
  alias EventsGrapAPI.Repo
  alias EventsGrapAPI.Schema.User

  def all(_parent, _args, _context) do
    {:ok, Repo.all(User)}
  end

  def create(_parent, args, _context) do
    if args.name == nil or args.email == nil or args.password_hash == nil do
      {:error, "Missing required arguments"}
    else
      changeset =
        User.changeset(%User{}, args)

      case Repo.insert(changeset) do
        {:ok, user} -> {:ok, user}
        {:error, changeset} -> {:error, changeset}
      end
    end
  end

  def update(_parent, args, _context) do
    case Repo.get(User, args.id) do
      nil ->
        {:error, "User not found"}

      user ->
        changeset = User.changeset(user, args)

        case Repo.update(changeset) do
          {:ok, updated_user} -> {:ok, updated_user}
          {:error, changeset} -> {:error, changeset}
        end
    end
  end

  def delete(_parent, args, _context) do
    case Repo.get(User, args.id) do
      nil ->
        {:error, "User not found"}

      user ->
        case Repo.delete(user) do
          {:ok, _} -> {:ok, %{id: args.id}}
          {:error, reason} -> {:error, reason}
        end
    end
  end

  def get_user(_parent, %{user_id: user_id}, _context) do
    user = Repo.get(User, user_id)
    {:ok, user}
  end

  def get_user(parent, _args, _context) do
    user = Repo.get(User, parent.user_id)
    {:ok, user}
  end
end
