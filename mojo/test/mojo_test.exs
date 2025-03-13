defmodule MojoTest do
  use ExUnit.Case
  doctest Mojo

  test "greets the world" do
    assert Mojo.hello() == :world
  end
end
