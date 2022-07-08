defmodule Pento.Game.Point do
  def new(x, y) when is_integer(x) and is_integer(y) do
    {x, y}
  end

  def move({x, y}, {change_x, change_y}) do
    {x + change_x, y + change_y}
  end
end
