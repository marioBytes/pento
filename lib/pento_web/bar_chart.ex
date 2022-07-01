defmodule PentoWeb.BarChart do
  alias Contex.{Dataset, BarChart, Plot}

  def make_bar_chart_dataset(data) do
    Dataset.new(data)
  end

  def make_bar_chart(dataset) do
    dataset |> BarChart.new()
  end

  def render_bar_chart(chart, title, subtitle, x_axis, y_axis) do
    Plot.new(500, 400, chart)
    |> Plot.titles(title, subtitle)
    |> Plot.axis_labels(x_axis, y_axis)
    |> Plot.to_svg()
  end
end
