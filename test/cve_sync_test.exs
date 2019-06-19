defmodule CveSyncTest do
  use ExUnit.Case
  doctest CveSync

  test "greets the world" do
    assert CveSync.hello() == :world
  end
end
