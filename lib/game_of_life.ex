defmodule GameOfLife do
  
  def tick(world) when world == [] do
    world
  end

  def tick(world) do
    kill_at(world, {1, 1}) 
    |> kill_at({1, 2})
  end

  def neighbors_count(world, {x, y}) do
    coordinates_to_check = 
      get_vertical_coordinates(world, {x, y}) ++ get_horizontal_coordinates(world, {x, y})
    neighbors = Enum.map(coordinates_to_check, &(get_value_from_coordinate_pair(world, &1)))
    Enum.count(neighbors, &(&1 == :alive))
  end

  defp get_vertical_coordinates(world, {x, y}) do
    possible_coordinates = [{x + 1, y}, {x - 1, y}]
    Enum.filter(possible_coordinates, fn({x, y}) -> validate_coordinate(world, x) end) 
  end

  defp get_horizontal_coordinates(world, {x, y}) do
    possible_coordinates = [{x, y + 1}, {x, y - 1}]
    Enum.filter(possible_coordinates, fn({x, y}) -> validate_coordinate(world, y) end) 
  end

  defp validate_coordinate(world, c) do
    c != 0 && c <= length(world)
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
end
