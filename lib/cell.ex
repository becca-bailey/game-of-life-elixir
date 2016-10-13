defmodule GameOfLife.Cell do
  def location(x, y) do
    {x, y}
  end

  def alive?(cell) do
    cell == :alive
  end
end
