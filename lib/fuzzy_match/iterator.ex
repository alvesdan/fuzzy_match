defmodule FuzzyMatch.Iterator do
  defstruct [ files: %{} ]

  def find_match(iterator, pattern, file) do
    points = FuzzyMatch.Pattern.match?(pattern, file)
    add_file(iterator, file, points)
  end

  def add_file(iterator, file, points) when points > 20 do
    files = Map.merge(iterator.files, %{ file => points })
    Map.put(iterator, :files, files)
  end

  def add_file(iterator, _file, _points), do: iterator
end