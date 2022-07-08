defmodule Pento.Game.Board do
  alias Pento.Game.{Pentomino, Shape}

  defstruct [
    active_pento: nil,
    completed_pentos: [],
    palette: [],
    points: []
  ]

  def puzzles(), do: ~w[default wide widest medium tiny]a
end
