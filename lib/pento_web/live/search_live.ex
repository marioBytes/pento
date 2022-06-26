defmodule PentoWeb.SearchLive do
  use PentoWeb, :live_view

  alias Pento.Search
  alias Pento.Search.Search, as: SearchTerm
  alias Pento.Catalog.Product

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_search()
      |> assign_changeset()
      |> assign(:product, nil)

    {:ok, socket}
  end

  def assign_search(socket) do
    socket |> assign(:search, %SearchTerm{})
  end

  def assign_changeset(%{assigns: %{search: search}} = socket) do
    socket |> assign(:changeset, Search.change_search(search))
  end

  def handle_event(
        "validate",
        %{"search" => search_params},
        %{assigns: %{search: search}} = socket
      ) do
    changeset =
      search
      |> Search.change_search(search_params)
      |> Map.put(:action, :validate)

    {:noreply, socket |> assign(:changeset, changeset)}
  end

  def handle_event(
        "save",
        %{"search" => %{"search_term" => search_term}},
        %{assigns: %{changeset: changeset}} = socket
      ) do
    if changeset.valid? do
      product = Search.find_product_by_sku(search_term)

      case product do
        nil ->
          {:noreply, socket |> put_flash(:error, "Cannot find that product")}

        %Product{} = product ->
          {:noreply, socket |> assign(:product, product)}
      end
    else
      {:noreply,
       socket
       |> assign(:changeset, changeset)
       |> put_flash(:error, "Please check search term for any errors")}
    end
  end
end
