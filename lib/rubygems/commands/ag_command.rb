require 'rubygems/command'
require 'pry'

class Gem::Commands::AgCommand < Gem::Command
  def initialize
    super 'ag', "Search for PATTERN in installed gem source using 'ag'"

    add_ag_opts possible_ag_opts
  end

  def arguments
    "PATTERN       Search Pattern"
  end

  def usage
    "#{program_name} PATTERN [GEMNAME ...]"
  end

  def execute
    search_term, gems_to_search = options[:args]
    paths = search_paths(gems_to_search).join ' '
    flags = ag_flags.join ' '

    execute_ag flags, search_term, paths
  end

  private

  def ag_flags
    @ag_flags ||= Array.new
  end

  def search_paths(*gems_to_search)
    specs = if gems_to_search
      Gem::Specification.find_all
    else
      Array(gems_to_search).map do |name|
        Gem::Specification.find_all_by_name name
      end.flatten
    end
    specs.map{|s| "\"#{s.full_gem_path}\""}
  end

  def add_ag_opts(list)
    list.each do |current_opt|
      add_option(*current_opt) do |value, options|
        ag_flags << current_opt.first.split(' ').first
        ag_flags << value unless value === true
      end
    end
  end

  def execute_ag(flags, search_term, paths)
    exec "ag #{flags} #{search_term} #{paths}"
  end

  # Holy hell this is a big list of things. Taken from the ag man page. If
  # there is a better way to pass options through the rubygems plugin system I
  # would love to refactor this to just pass the options along to the ag
  # command.
  def possible_ag_opts
    [
      ["--ackmate",                           "Output results in a format parseable by AckMate https://github.com/protocool/AckMate."],
      ["-a", "--all-types",                   "Search all files. This doesn't include hidden files, and doesn't respect any ignore files."],
      ["-A", "--after [LINES]",               "Print lines after match. Defaults to 2."],
      ["-B", "--before [LINES]",              "Print lines before match. Defaults to 2."],
      ["--break",                             "Print a newline between matches in different files. Enabled by default."],
      ["--nobreak",                           "Don't print a newline between matches in different files. Enabled by default."],
      ["--color",                             "Print color codes in results. Enabled by default."],
      ["--nocolor",                           "Don't print color codes in results. Enabled by default."],
      ["--color-line-number",                 "Color codes for line numbers. Defaults to 1;33."],
      ["--color-match",                       "Color codes for result match numbers. Defaults to 30;43."],
      ["--color-path",                        "Color codes for path names. Defaults to 1;32."],
      ["--column",                            "Print column numbers in results."],
      ["-C", "--context [LINES]",             "Print lines before and after matches. Defaults to 2."],
      ["-D", "--debug",                       "Output ridiculous amounts of debugging info. Probably not use-ful."],
      ["--depth NUM",                         "Search up to NUM directories deep. Default is 25."],
      ["-f", "--follow",                      "Follow symlinks."],
      ["--group",                             "The default, --group,lumps multiple matches in the same file together,and presents them under a single occurrence of the filename. --nogroup refrains from this, and instead places the filename at the start of each match line."],
      ["--nogroup",                           "Don't lumps multiple matches in the same file together."],
      ["-g PATTERN",                          "Print filenames matching PATTERN."],
      ["-G", "--file-search-regex PATTERN",   "Only search files whose names match PATTERN."],
      ["-H", "--heading",                     "Print filenames above matching contents."],
      ["-H", "--noheading",                   "Don't print filenames above matching contents."],
      ["--hidden",                            "Search hidden files. This option obeys ignore files."],
      ["--ignore PATTERN",                    "Ignore files/directories whose names match this pattern. Literal file and directory names are also allowed."],
      ["--ignore-dir NAME",                   "Alias for --ignore for compatibility with ack."],
      ["-i", "--ignore-case",                 "Match case-insensitively."],
      ["-l", "--files-with-matches",          "Only print the names of files containing matches,not the match-ing lines. An empty query will print all files that would be searched."],
      ["-L", "--files-without-matches",       "Only print the names of files that don't contain matches."],
      ["--list-file-types",                   "See file types."],
      ["-m", "--max-count NUM",               "Skip the rest of a file after NUM matches. Default is 10,000."],
      ["--no-numbers",                        "Don't show line numbers."],
      ["-p", "--path-to-agignore STRING",     "Provide a path to a specific .agignore file."],
      ["--pager COMMAND",                     "Use a pager such as less. Use --nopager to override. This option is also ignored if output is piped to another program."],
      ["--print-long-lines",                  "Print matches on very long lines (> 2k characters by default)."],
      ["--passthrough",                       "When searching a stream, print all lines even if they don't match."],
      ["-Q", "--literal",                     "Do not parse PATTERN as a regular expression. Try to match it literally."],
      ["-s", "--case-sensitive",              "Match case-sensitively."],
      ["-S", "--smart-case",                  "Match case-sensitively if there are any uppercase letters in PATTERN, case-insensitively otherwise. Enabled by default."],
      ["--search-binary",                     "Search binary files for matches."],
      ["--silent",                            "Suppress all log messages, including errors."],
      ["--stats",                             "Print stats (files scanned, time taken, etc)."],
      ["-t", "--all-text",                    "Search all text files. This doesn't include hidden files."],
      ["-u", "--unrestricted",                "Search all files. This ignores .agignore, .gitignore, etc. It searches binary and hidden files as well."],
      ["-U", "--skip-vcs-ignores",            "Ignore VCS ignore files (.gitignore, .hgignore, svn:ignore), but still use .agignore."],
      ["-v", "--invert-match",                "Match every line not containing the specified pattern."],
      ["--vimgrep",                           "Output results like vim's :vimgrep /pattern/g would (it reports every match on the line)."],
      ["-w", "--word-regexp",                 "Only match whole words."],
      ["-z", "--search-zip",                  "Search contents of compressed files."],
      ["-0", "--null",                        "Separate the filenames with \\0, rather than \\n: this allows xargs -0 <command> to correctly process filenames containing spaces or newlines."],
    ]
  end
end

