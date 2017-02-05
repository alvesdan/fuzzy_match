defmodule FuzzyMatch do
  def find(pattern, files) do
    find(pattern, Enum.sort(files), %FuzzyMatch.Iterator{})
  end

  def find(pattern, [head|tail], iterator) do
    iterator = FuzzyMatch.Iterator.find_match(iterator, pattern, head)
    find(pattern, tail, iterator)
  end

  def find(_pattern, [], iterator) do
    iterator.files
    |> Enum.sort_by(fn({_f, p}) -> p end)
    |> Enum.reduce([], fn({f, _p}, acc) -> [f] ++ acc end)
  end

  @doc """
  Exclude files from result using a regex pattern

  Examples:

      iex> FuzzyMatch.exclude(["folder/example", "folder/file"], ["example"])
      ["folder/file"]
  """
  @spec exclude(list, list) :: list
  def exclude(files, []), do: files
  def exclude(files, exclude_list) do
    Enum.reject(files, fn(file) ->
      Enum.any?(exclude_list, fn(regex) ->
        Regex.compile!(regex) |> Regex.match?(file)
      end)
    end)
  end
end
