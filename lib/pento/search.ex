defmodule Pento.Search do
  alias Pento.Repo
  alias Pento.Search.Search, as: SearchTerm
  alias Pento.Catalog.Product

  def change_search(%SearchTerm{} = search_term, attrs \\ %{}) do
    SearchTerm.changeset(search_term, attrs)
  end

  def find_product_by_sku(sku) do
    Repo.get_by(Product, %{sku: sku})
  end
end
