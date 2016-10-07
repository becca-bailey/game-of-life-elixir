defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife
  alias GameOfLife, as: Game
  
  test "a new game has an empty world" do
    assert Game.new |> Game.is_empty 
  end

  test "a living cell can be added to the world" do
    assert Game.new 
      |> Game.world_size(1)
      |> Game.set_living_at({1, 1}) 
      |> Game.alive_at?({1, 1})
  end

  test "after adding a cell the world is not empty" do
    refute Game.new 
      |> Game.world_size(1)
      |> Game.set_living_at({1, 1})
      |> Game.is_empty
  end

  test "an empty world is still empty after one tick" do
    assert Game.new 
      |> Game.tick 
      |> Game.is_empty
  end

  test "a living cell with no neighbors dies in the next generation" do
    refute Game.new
      |> Game.world_size(1)
      |> Game.set_living_at({1, 1})
      |> Game.tick
      |> Game.alive_at?({1, 1}) 
  end

  test "a living cell with only one neighbor dies in the next generation" do
    refute Game.new
      |> Game.world_size(2)
      |> Game.set_living_at({1, 1})
      |> Game.set_living_at({1, 2})
      |> Game.tick
      |> Game.alive_at?({1, 1})
    
    refute Game.new
      |> Game.world_size(2)
      |> Game.set_living_at({1, 1})
      |> Game.set_living_at({1, 2})
      |> Game.tick
      |> Game.alive_at?({1, 2}) 
  end

  test "a living single cell has no neighbors" do
    world = Game.new
           |> Game.world_size(1)
           |> Game.set_living_at({1, 1})
    assert Game.neighbors_count(world, {1, 1}) == 0
  end

  test "a living cell next to another living cell has one neighbor" do
    world = Game.new
            |> Game.world_size(2)
            |> Game.set_living_at({1, 1})
            |> Game.set_living_at({1, 2})
    assert Game.neighbors_count(world, {1, 1}) == 1
    assert Game.neighbors_count(world, {1, 2}) == 1
  end
end
