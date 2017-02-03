defmodule FuzzyMatch.IO do
  def main([pattern]), do: process(pattern, ".")
  def main([pattern, folder]), do: process(pattern, folder)

  def process(pattern, folder) do
    {output, _code} = System.cmd("find", [".", "-type", "f"], cd: folder)
    files = String.split(output, "\n", trim: true)
    files_count = Enum.count(files)
    
    IO.puts "#{IO.ANSI.yellow}Looking for `#{pattern}` in `#{folder}` with #{files_count} files to analyze:#{IO.ANSI.reset}"
    
    FuzzyMatch.find(pattern, files)
    |> Enum.map(fn(file) ->
      Path.expand("#{folder}/#{file}") |> Path.relative_to_cwd
    end)
    |> Enum.each(&IO.puts/1)
  end
end