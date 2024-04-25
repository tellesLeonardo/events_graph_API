defmodule EventsGrapAPI.GraphSchema.Types do
  use Absinthe.Schema.Notation

  scalar :datetime, description: "An ISO 8601 date and time" do
    serialize(&DateTime.to_iso8601/1)

    parse(fn
      %Absinthe.Blueprint.Input.String{value: value} ->
        case DateTime.from_iso8601(value) do
          {:ok, datetime, _} -> {:ok, datetime}
          _ -> :error
        end

      _ ->
        :error
    end)
  end
end
