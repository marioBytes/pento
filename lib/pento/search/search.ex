defmodule Pento.Search.Search do
  defstruct [:search_term]
  @types %{search_term: :string}

  import Ecto.Changeset

  def changeset(%__MODULE__{} = search_term, attrs) do
    {search_term, @types}
    |> cast(attrs, Map.keys(@types))
    |> validate_required(:search_term)
    |> validate_length(:search_term, min: 7)
  end
end
