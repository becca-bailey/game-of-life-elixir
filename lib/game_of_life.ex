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
end
