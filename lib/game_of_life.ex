defmodule GameOfLife do
  
  def new do
    [] 
  end

  def size(world, n) when length(world) == n do
    world
  end

  def world_size(world, size) do
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

  def is_alive_at(world, {x, y}) do
    Enum.at(world, index(x)) |> Enum.at(index(y)) |> is_alive 
  end

  def tick(world) when world == [] do
    world
  end

  def tick(world) do
    kill_at(world, {1, 1}) 
    |> kill_at({1, 2})
  end

  defp index(n) do
    n - 1
  end

  defp kill_at(world, {x, y}) do
    List.update_at(world, index(x), &(List.replace_at(&1, index(y), :dead)))
  end

  defp is_alive(cell) do
    cell == :alive
  end
  
end
