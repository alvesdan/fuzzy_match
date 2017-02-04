defmodule FuzzyMatch.Pattern do
  import String, only: [codepoints: 1, downcase: 1]

  def match?(pattern, file) when is_binary(pattern),
    do: match?(codepoints(pattern), codepoints(file), 0, 0)

  def match?([], _file, points, _current_match), do: points
  def match?(_pattern, [], points, _current_match), do: points
  def match?(pattern, file, points, current_match) do
    [pattern_char|pattern_tail] = pattern
    [file_char|file_tail] = file

    sum_points = points_for(pattern_char, file_char, current_match)

    if sum_points > 0 do
      match?(pattern_tail, file_tail,
        points + sum_points, current_match + 1)
    else
      match?(pattern, file_tail, points, 0)
    end
  end

  defp points_for("/", "/", _current_match), do: 10
  defp points_for(".", ".", _current_match), do: 10

  defp points_for(pattern_char, file_char, current_match)
    when (pattern_char == file_char) and current_match > 3, do: 20

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
    downcase(left) == downcase(right)
  end
end