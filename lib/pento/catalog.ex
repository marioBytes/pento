defmodule Pento.Catalog do
  import Ecto.Query, warn: false
  alias Pento.Repo

  alias Pento.Catalog.Product

  def list_products_with_user_rating(user) do
    Product.Query.with_user_ratings(user)
    |> Repo.all()
  end

  def products_with_average_ratings(%{age_group_filter: age_group_filter, gender_group_filter: gender_group_filter}) do
    Product.Query.with_average_ratings()
    |> Product.Query.join_users()
    |> Product.Query.join_demographics()
    |> Product.Query.filter_by_age_group(age_group_filter)
    |> Product.Query.filter_by_gender_group(gender_group_filter)
    |> Repo.all()
  end

  def products_with_zero_ratings() do
    Product.Query.with_zero_ratings()
    |> Repo.all()
  end

  def list_products do
    Repo.all(Product)
  end

  def get_product!(id), do: Repo.get!(Product, id)

  def create_product(attrs \\ %{}) do
    %Product{}
    |> Product.changeset(attrs)
    |> Repo.insert()
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> Product.changeset(attrs)
    |> Repo.update()
  end

  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  def change_product(%Product{} = product, attrs \\ %{}) do
    Product.changeset(product, attrs)
  end

  def markdown_product(%Product{} = product, attrs \\ %{}) do
    Product.unit_price_changeset(product, attrs)
  end
end
