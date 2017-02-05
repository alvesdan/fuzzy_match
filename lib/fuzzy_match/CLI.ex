defmodule FuzzyMatch.CLI do
  @switches [
    limit: :integer,
    exclude: :keep
  ]

  def main([]) do
    IO.puts """
    Usage: fuzzy_match [--limit] PATTERN [FOLDER]

    The following options are available:

    --limit     Limit the number of results to display
    --exclude   Exclude from results using regex
    """
  end

  def main(args) do
    {opts, pattern, folder} = args |> parse_args
    process(pattern, folder, opts)
  end

  def process(pattern, folder, opts) do
    {output, _code} = System.cmd("find", [".", "-type", "f"], cd: folder)
    files = String.split(output, "\n", trim: true)
    files_count = Enum.count(files)

    IO.puts "#{IO.ANSI.yellow}Looking for `#{pattern}` in `#{folder}` with \
#{files_count} files to analyze:#{IO.ANSI.reset}"

    pattern
    |> FuzzyMatch.find(files)
    |> FuzzyMatch.exclude(Keyword.get_values(opts, :exclude))
    |> Enum.map(&format(&1, folder))
    |> Enum.take(opts[:limit] || 20)
    |> Enum.sort
    |> Enum.each(&IO.puts/1)
  end

  defp parse_args(args) do
    case OptionParser.parse(args, switches: @switches) do
      {opts, [pattern, folder], _} -> {opts, pattern, folder}
      {opts, [pattern], _} -> {opts, pattern, "."}
    end
  end

  defp format(file, folder) do
    "#{folder}/#{file}"
    |> Path.expand
    |> Path.relative_to_cwd
  end
end