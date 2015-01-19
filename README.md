# Gem::Ag

RubyGems plugin to search with [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gem-ag'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gem-ag

## Usage

The `gem ag` command attempts to support all the same command line options as `ag` out of the box. The big difference is you cannot specify paths to search. Instead you can pass in a list of gem names.

```
Usage: gem ag PATTERN [GEMNAME ...] [options]
```

### Examples

Search for "Hello World" in Rails and Active Record gems.

```
gem ag "Hello World" rails active-record
```

Search for "def" in the rake gem, and print ag stats.

```
gem ag --stats "def" rake
````

Search in all installed gems:

```
gem ag "Hello World"
```

By using `bundle exec` you can search only in the gems in yoru bundle.

Search in all bundled gems:

```
bundle exec gem ag "Hello World"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gem-ag/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
