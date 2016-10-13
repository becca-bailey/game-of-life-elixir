defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife

  alias GameOfLife, as: Game
  alias GameOfLife.World
  
  test "a new game has an empty world" do
    assert World.new |> World.is_empty 
  end

  test "a living cell can be added to the world" do
    assert World.new 
      |> World.set_size(1)
      |> World.set_living_at({1, 1}) 
      |> World.alive_at?({1, 1})
  end

  test "after adding a cell the world is not empty" do
    refute World.new 
      |> World.set_size(1)
      |> World.set_living_at({1, 1})
      |> World.is_empty
  end

  test "an empty world is still empty after one tick" do
    assert World.new 
      |> Game.tick 
      |> World.is_empty
  end

  test "a living cell with no neighbors dies in the next generation" do
    world = 
      World.new
      |> World.set_size(1)
      |> World.set_living_at({1, 1})
      |> Game.tick
    
    refute World.alive_at?(world, {1, 1}) 
  end

  test "a living cell with only one neighbor dies in the next generation" do
    refute World.new
      |> World.set_size(2)
      |> World.set_living_at({1, 1})
      |> World.set_living_at({1, 2})
      |> Game.tick
      |> World.alive_at?({1, 1})
    
    refute World.new
      |> World.set_size(2)
      |> World.set_living_at({1, 1})
      |> World.set_living_at({1, 2})
      |> Game.tick
      |> World.alive_at?({1, 2}) 
  end

  test "a living single cell has no neighbors" do
    world = World.new
           |> World.set_size(1)
           |> World.set_living_at({1, 1})
    assert Game.neighbors_count(world, {1, 1}) == 0
  end

  test "a living cell next to another living cell has one neighbor" do
    world = World.new
            |> World.set_size(2)
            |> World.set_living_at({1, 1})
            |> World.set_living_at({1, 2})
    assert Game.neighbors_count(world, {1, 1}) == 1
    assert Game.neighbors_count(world, {1, 2}) == 1
  end

  test "a living cell with another living cell below it has one neighbor" do
    world = World.new
            |> World.set_size(2)
            |> World.set_living_at({1, 1})
            |> World.set_living_at({2, 1})
    assert Game.neighbors_count(world, {1, 1}) == 1
    assert Game.neighbors_count(world, {2, 1}) == 1
  end

  test "a living cell with living cells next to and below it has two neighbors" do
    world = World.new
            |> World.set_size(2)
            |> World.set_living_at({1, 1})
            |> World.set_living_at({1, 2})
            |> World.set_living_at({2, 1})
    assert Game.neighbors_count(world, {1, 1}) == 2
  end

end
