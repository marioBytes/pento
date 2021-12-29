defmodule Pento.Catalog.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :description, :string
    field :name, :string
    field :sku, :integer
    field :unit_price, :float

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :description, :unit_price, :sku])
    |> validate_required([:name, :description, :unit_price, :sku])
    |> unique_constraint(:sku)
    |> validate_number(:unit_price, greater_than: 0.0)
  end

  def unit_price_changeset(product, attrs) do
    product
    |> cast(attrs, [:unit_price])
    |> case do
      %{changes: %{unit_price: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :unit_price, "did not change")
    end
    |> validate_price_update()
  end

  defp validate_price_update(changeset) do
    id = get_field(changeset, :id)
    prev_product = Pento.Catalog.get_product!(id)

    prev_price = prev_product.unit_price
    new_price = get_field(changeset, :unit_price)

    if prev_price == new_price or new_price < prev_price do
      changeset
    else
      add_error(changeset, :unit_price, "New price cannot be greater than current price")
    end
  end
end
