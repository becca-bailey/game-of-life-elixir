defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife

  test "a new game has an empty world" do
    assert GameOfLife.is_empty(GameOfLife.world) == true 
  end
end
