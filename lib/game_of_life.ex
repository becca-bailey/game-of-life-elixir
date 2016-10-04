defmodule GameOfLife do
  @world []
  
  def is_empty(world) when world == [] do
    true
  end

  def is_empty(world) do
    false
  end

  def world do
    @world
  end

  def set_living_at({x, y}) do
    [[:alive]]
  end

  def is_alive_at(world, {x, y}) do
    true
  end
end
