defmodule Pento.Game.Shape do
  defstruct color: :blue, name: :x, points: []

  defp color(:i), do: :dark_green
  defp color(:l), do: :green
  defp color(:y), do: :light_green
  defp color(:n), do: :dark_orange
  defp color(:p), do: :orange
  defp color(:w), do: :light_orange
  defp color(:u), do: :dark_gray
  defp color(:v), do: :gray
  defp color(:s), do: :light_gray
  defp color(:f), do: :dark_blue
  defp color(:x), do: :blue
  defp color(:t), do: :light_blue

  defp points(:i), do: [{3, 1}, {3, 2}, {3, 3}, {3, 4}, {3, 5}]
  defp points(:l), do: [{3, 1}, {3, 2}, {3, 3}, {3, 4}, {4, 4}]
  defp points(:y), do: [{3, 1}, {2, 2}, {3, 2}, {3, 3}, {3, 4}]
  defp points(:n), do: [{3, 1}, {3, 2}, {3, 3}, {4, 3}, {4, 4}]
  defp points(:p), do: [{3, 2}, {4, 3}, {3, 3}, {4, 2}, {3, 4}]
  defp points(:w), do: [{2, 2}, {2, 3}, {3, 3}, {3, 4}, {4, 4}]
  defp points(:u), do: [{2, 2}, {4, 2}, {2, 3}, {3, 3}, {4, 3}]
  defp points(:v), do: [{2, 2}, {2, 3}, {2, 4}, {3, 4}, {4, 4}]
  defp points(:s), do: [{3, 2}, {4, 2}, {3, 3}, {2, 4}, {3, 4}]
  defp points(:f), do: [{3, 2}, {4, 2}, {2, 3}, {3, 3}, {3, 4}]
  defp points(:x), do: [{3, 2}, {2, 3}, {3, 3}, {4, 3}, {3, 4}]
  defp points(:t), do: [{2, 2}, {3, 2}, {4, 2}, {3, 3}, {3, 4}]
end
