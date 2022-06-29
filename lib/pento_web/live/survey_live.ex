defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view

  alias __MODULE__.Component

  alias Pento.Survey
  alias Pento.Catalog
  alias PentoWeb.DemographicLive
  alias PentoWeb.DemographicLive.Form
  alias PentoWeb.RatingLive
  alias PentoWeb.RatingLive.Index

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_demographic()
      |> assign_list_items()
      |> assign_products()

    {:ok, socket}
  end

  def handle_info({:created_demographic, demographic}, socket) do
    {:noreply, handle_demographic_created(socket, demographic)}
  end

  defp assign_demographic(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :demographic, Survey.get_demographic_by_user(current_user))
  end

  defp assign_products(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, :products, list_products(current_user))
  end

  defp handle_demographic_created(socket, demographic) do
    socket
    |> put_flash(:info, "Demographic info has been saved")
    |> assign(:demographic, demographic)
  end

  defp list_products(user) do
    Catalog.list_products_with_user_rating(user)
  end

  defp assign_list_items(socket) do
    items = [
      "item1",
      "item2",
      "item3",
    ]
    assign(socket, :items, items)
  end
end
