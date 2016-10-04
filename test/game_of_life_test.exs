defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife
  
  test "a new game has an empty world" do
    assert GameOfLife.new |> GameOfLife.is_empty 
  end

  test "a living cell can be added to the world" do
    assert GameOfLife.new 
      |> GameOfLife.world_size(1)
      |> GameOfLife.set_living_at({1, 1}) 
      |> GameOfLife.is_alive_at({1, 1})
  end

  test "after adding a cell the world is not empty" do
    refute GameOfLife.new 
      |> GameOfLife.world_size(1)
      |> GameOfLife.set_living_at({1, 1})
      |> GameOfLife.is_empty
  end

  test "an empty world is still empty after one tick" do
    assert GameOfLife.new 
      |> GameOfLife.tick 
      |> GameOfLife.is_empty
  end

  test "a living cell with no neighbors dies in the next generation" do
    refute GameOfLife.new
      |> GameOfLife.world_size(1)
      |> GameOfLife.set_living_at({1, 1})
      |> GameOfLife.tick
      |> GameOfLife.is_alive_at({1, 1}) 
  end

  test "a living cell with only one neighbor dies in the next generation" do
    refute GameOfLife.new
      |> GameOfLife.world_size(2)
      |> GameOfLife.set_living_at({1, 1})
      |> GameOfLife.set_living_at({1, 2})
      |> GameOfLife.tick
      |> GameOfLife.is_alive_at({1, 1})
    
    refute GameOfLife.new
      |> GameOfLife.world_size(2)
      |> GameOfLife.set_living_at({1, 1})
      |> GameOfLife.set_living_at({1, 2})
      |> GameOfLife.tick
      |> GameOfLife.is_alive_at({1, 2}) 
  end
end
