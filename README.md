# FuzzyMatch

FuzzyMatch is a tool to find files using a pattern (and an excuse to write Elixir and have fun) :smile:

I will try to add new features and improve the fuzzy match algorithm slowly. Contributions are very welcome.

## Installation

  1. Clone `fuzzy_match` repo:

  ```
  git clone https://github.com/alvesdan/fuzzy_match.git
  ```

  2. Build executable

  ```
  mix escript.build
  ```

  3. Create symlink to `fuzzy_match` to use it anywhere

  ```
  ln -s /usr/local/bin/fuzzy_match fuzzy_match
  ```

## Usage

  ```
  fuzzy_match
  Usage: fuzzy_match [--limit] PATTERN [FOLDER]

  The following options are available:

  --limit     Limit the number of results to display
  ```

## Contributing

Bug reports and pull requests are welcome on GitHub.

## Todo

  - [ ] Exclude folders from search
  - [ ] Exclude files from search
  - [ ] Improve fuzzy match algorithm