defmodule EventsGrapAPI.Resolvers.Users do

  alias EventsGrapAPI.Repo

  def all(_parent, _args) do
    # {:ok, Repo.all(Author)}
    :ok
  end

end
