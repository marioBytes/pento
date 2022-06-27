defmodule Pento.Survey.Rating.Query do
  import Ecto.Query
  alias Pento.Survey.Rating

  def base() do
    Rating
  end

  def preload_user(user) do
    base()
    |> for_user(user)
  end

  def for_user(query, user) do
    query
    |> where([r], r.user_id == ^user.id)
  end
end
