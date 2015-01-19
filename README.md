# Gem::Ag

Quickly search through all the code in your installed gems using `ag`.

RubyGems plugin to search with [The Silver Searcher](https://github.com/ggreer/the_silver_searcher), this was inspired by Jim Gay's [Searching Through Your Bundled Gems](http://www.saturnflyer.com/blog/jim/2013/03/15/searching-through-your-bundled-gems/) blog post.


## Installation

Install it with rubygems:

    $ gem install gem-ag

Or to include it with your app add this line to your application's Gemfile:

```ruby
gem 'gem-ag'
```

And then execute:

    $ bundle


## Usage

The `gem ag` command attempts to support all the same command line options as `ag` out of the box. The big difference is you cannot specify paths to search. Instead you can pass in a list of gem names.

    gem ag PATTERN [GEMNAME ...] [options]

To see a full list of supported options run:

    gem help ag

### Examples

Search for "Hello World" in Rails and Active Record gems.

    gem ag "Hello World" rails active-record

Search for "def" in the rake gem, and print ag stats.

    gem ag --stats "def" rake

Search in all installed gems:

    gem ag "Hello World"

By using `bundle exec` you can search only in the gems in yoru bundle. This does require you to include it in your application's `Gemfile`.

Search in all bundled gems:

    bundle exec gem ag "Hello World"

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gem-ag/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
