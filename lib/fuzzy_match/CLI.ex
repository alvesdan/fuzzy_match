defmodule FuzzyMatch.CLI do
  def main(args \\ []) do
    {opts, pattern, folder} = args |> parse_args
    process(pattern, folder, opts)
  end

  def process(pattern, folder, opts) do
    {output, _code} = System.cmd("find", [".", "-type", "f"], cd: folder)
    files = String.split(output, "\n", trim: true)
    files_count = Enum.count(files)
    
    IO.puts "#{IO.ANSI.yellow}Looking for `#{pattern}` in `#{folder}` with \
#{files_count} files to analyze:#{IO.ANSI.reset}"
    
    FuzzyMatch.find(pattern, files)
    |> Enum.map(&format(&1, folder))
    |> Enum.take(opts[:limit] || 20)
    |> Enum.each(&IO.puts/1)
  end
  
  defp parse_args(args) do
    case OptionParser.parse(args, switches: [limit: :integer]) do
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