defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view

  alias __MODULE__.Component

  alias Pento.Survey
  alias Pento.Catalog
  alias PentoWeb.DemographicLive
  alias PentoWeb.DemographicLive.Form
  alias PentoWeb.RatingLive
  alias PentoWeb.RatingLive.Index
  alias PentoWeb.ButtonLive

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_demographic()
      |> assign_list_items()
      |> assign_products()
      |> assign_toggle()

    {:ok, socket}
  end

  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  def handle_info({:created_rating, updated_product, product_index}, socket) do
    {:noreply, handle_rating_created(socket, updated_product, product_index)}
  end

  def handle_event("toggle-content", _, %{assigns: %{content_shown: content_shown}} = socket) do
    content_shown = not content_shown
    {:noreply, assign(socket, :content_shown, content_shown)}
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographic, Survey.get_demographic_by_user(current_user))
  end

  defp assign_products(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :products, list_products(current_user))
  end

  defp assign_toggle(socket) do
    assign(socket, :content_shown, true)
  end

  defp handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic info has been saved")
    |> assign(:demographic, demographic)
  end

  defp handle_rating_created(
         %{assigns: %{products: products}} = socket,
         updated_product,
         product_index
       ) do
    socket
    |> put_flash(:info, "Rating submitted successfully")
    |> assign(:products, List.replace_at(products, product_index, updated_product))
  end

  defp list_products(user) do
    Catalog.list_products_with_user_rating(user)
  end

  defp assign_list_items(socket) do
    items = [
      "item1",
      "item2",
      "item3"
    ]

    assign(socket, :items, items)
  end
end
