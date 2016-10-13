defmodule GameOfLife.World do
  alias GameOfLife.Cell  

  def new do
    []
  end

  def set_size(world, size) do
    add_rows(world, size, size)
  end 

  defp add_rows(world, size, counter) when counter == 0 do
    world
  end

  defp add_rows(world, size, counter) do
    List.insert_at(world, 0, build_row(size))
    |> add_rows(size, counter - 1)
  end

  defp build_row(n) do
    Enum.to_list(1..n)
    |> Enum.map(fn x -> :dead end)
  end

  def is_empty(world) when world == [] do
    true
  end

  def is_empty(world) do
    false
  end

  def set_living_at(world, {x, y}) do
    List.update_at(world, index(x), &(List.replace_at(&1, index(y), :alive)))
  end

  def alive_at?(world, {x, y}) do
    get_at_coordinate(world, x) |> get_at_coordinate(y) |> Cell.alive? 
  end

  defp get_at_coordinate(coll, coordinate) do
    Enum.at(coll, index(coordinate))
  end

  defp index(n) do
    n - 1
  end

  defp coordinate(n) do
    n + 1
  end
end
