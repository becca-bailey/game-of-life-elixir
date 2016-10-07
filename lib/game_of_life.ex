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

  def alive_at?(world, {x, y}) do
    get_at_coordinate(world, x) |> get_at_coordinate(y) |> alive? 
  end

  def tick(world) when world == [] do
    world
  end

  def tick(world) do
    kill_at(world, {1, 1}) 
    |> kill_at({1, 2})
  end

  def neighbors_count(world, {x, y}) do
    coordinates_to_check = 
      get_horizontal_coordinates(world, {x, y})
    neighbors = Enum.map(coordinates_to_check, &(get_value_from_coordinate_pair(world, &1)))
    Enum.count(neighbors, &(&1 == :alive))
  end

  defp get_horizontal_coordinates(world, {x, y}) do
    cond do
      length(world) == 1 ->
        []
      x == 1 ->  
        [{2, y}]
      x == length(world)
        [{length(world) - 1, y}]
      true ->
        [{x - 1, y}, {x + 1, y}]
    end
  end

  defp get_value_from_coordinate_pair(coll, {x, y}) do
    coll 
    |> get_at_coordinate(x)
    |> get_at_coordinate(y)
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

  defp kill_at(world, {x, y}) do
    List.update_at(world, index(x), &(List.replace_at(&1, index(y), :dead)))
  end

  defp alive?(cell) do
    cell == :alive
  end
  
end
