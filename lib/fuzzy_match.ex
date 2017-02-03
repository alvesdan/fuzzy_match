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
    |> Enum.take(20)
  end
end
