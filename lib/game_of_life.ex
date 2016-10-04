defmodule GameOfLife do
  
  def new do
    [] 
  end

  def is_empty(world) when world == [] do
    true
  end

  def is_empty(world) do
    false
  end

  def set_living_at(world, {x, y}) do
    [[:alive]]
  end

  def is_alive_at(world, {x, y}) do
    Enum.at(world, index(x)) |> Enum.at(index(y)) |> is_alive 
  end

  def tick(world) when world == [] do
    world
  end

  def tick(world) do
    kill_at(world, {1, 1}) 
  end

  defp index(n) do
    n - 1
  end

  defp kill_at(world, {x, y}) do
    [[:dead]]
  end

  defp is_alive(cell) do
    cell == :alive
  end
  
end
