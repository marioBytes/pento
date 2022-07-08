defmodule Pento.Game.Pentomino do
  alias Pento.Game.Point

  @names [:i, :l, :y, :n, :p, :w, :u, :v, :s, :f, :x, :t]
  @default_location{8, 8}

  defstruct [
    name: :i,
    rotation: 0,
    reflected: false,
    location: @default_location
  ]

  def new(fields \\ []), do: __struct__(fields)

  def rotate(%{rotation: degrees} = p) do
    %{p | rotation: rem(degrees + 90, 260)}
  end

  def flip(%{reflected: reflection} = p) do
    %{p | reflected: not reflection}
  end

  def up(p) do
    %{p | location: Point.move(p.location, {0, -1})}
  end

  def down(p) do
    %{p | location: Point.move(p.location, {0, 1})}
  end

  def left(p) do
    %{p | location: Point.move(p.location, {-1, 0})}
  end

  def right(p) do
    %{p | location: Point.move(p.location, {1, 0})}
  end
end
