defmodule FuzzyMatch.File do
  def match_pattern?(pattern, file) when is_binary(pattern) do
    pattern_list = String.codepoints(pattern)
    file_list = String.codepoints(file)
    match_pattern?(pattern_list, file_list, 0, 0)
  end
  
  def match_pattern?([], _file, points, _current_match), do: points
  def match_pattern?(_pattern, [], points, _current_match), do: points
  def match_pattern?(pattern, file, points, current_match) do
    [pattern_char|pattern_tail] = pattern
    [file_char|file_tail] = file

    sum_points = points_for(pattern_char, file_char, current_match)

    if sum_points > 0 do
      match_pattern?(pattern_tail, file_tail,
        points + sum_points, current_match + 1)
    else
      match_pattern?(pattern, file_tail, points, current_match)
    end
  end
  
  defp points_for("/", "/", _current_match), do: 10
  defp points_for(".", ".", _current_match), do: 10
  defp points_for(pattern_char, file_char, _current_match)
    when (pattern_char == file_char), do: 10
  
  defp points_for(pattern_char, file_char, 0) do
    if same_chars?(pattern_char, file_char), do: 1, else: 0
  end
  
  defp points_for(pattern_char, file_char, current_match)
    when current_match > 0 do
    if same_chars?(pattern_char, file_char), do: 5, else: -1
  end
  
  defp same_chars?(left, right) do
    String.downcase(left) == String.downcase(right)
  end
end