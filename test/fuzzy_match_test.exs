defmodule FuzzyMatchTest do
  use ExUnit.Case
  doctest FuzzyMatch
  
  @files [
    "lib/helpers/utils.ex",
    "test/plugins/handler.ex",
    "lib/plugins/handler.ex"
  ]

  test "it finds libhelpersut" do
    match = FuzzyMatch.find("libhelpersut", @files)
    assert List.first(match) == "lib/helpers/utils.ex"
  end
  
  test "it finds pluhand" do
    match = FuzzyMatch.find("pluhand", @files) 
    assert List.first(match) == "test/plugins/handler.ex"
  end
  
  test "it finds test/handler" do
    match = FuzzyMatch.find("test/handler", @files)
    assert List.first(match) == "test/plugins/handler.ex"
  end
end
