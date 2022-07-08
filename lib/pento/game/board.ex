defmodule Pento.Game.Board do
  alias Pento.Game.{Pentomino, Shape}

  defstruct [
    active_pento: nil,
    completed_pentos: [],
    palette: [],
    points: []
  ]

  def puzzles(), do: ~w[default wide widest medium tiny]a

  def new(palette, points) do
    %__MODULE__{palette: palette(palette), points: points}
  end

  def new(:tiny), do: new(:small, rect(5, 3))
  def new(:widest), do: new(:all, rect(20, 3))
  def new(:wide), do: new(:all, rect(15, 4))
  def new(:medium), do: new(:all, rect(12, 5))
  def new(:default), do: new(:all, rect(10, 6))
end
