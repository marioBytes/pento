defmodule PentoWeb.Admin.SurveyResultsLive do
  use PentoWeb, :live_component

  alias Pento.Catalog

  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_products_with_average_ratings()
     |> assign_dataset()
     |> assign_chart()}
  end

  defp assign_products_with_average_ratings(socket) do
    socket |> assign(:products_with_average_ratings, Catalog.products_with_average_ratings())
  end

  def assign_dataset(
        %{assigns: %{products_with_average_ratings: products_with_average_ratings}} = socket
      ) do
    socket |> assign(:dataset, make_bar_chart_dataset(products_with_average_ratings))
  end

  defp make_bar_chart_dataset(data) do
    Contex.Dataset.new(data)
  end

  defp assign_chart(%{assigns: %{dataset: dataset}} = socket) do
    socket |> assign(:chart, make_bar_chart(dataset))
  end

  defp make_bar_chart(dataset) do
    Contex.BarChart.new(dataset)
  end
end
