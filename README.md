# Multiline

A Gem that manipulates a multi-line string as if it were a single line of String.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'multiline'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install multiline

## Usage

```ruby
text = Multiline::String.new(
<<EOF
aaa
bbb
ccc
ddd
eee
EOF
)

ext2 = Multiline::String.new(
<<EOF
111
222
333
EOF
)

puts text.concat(text2)
aaa
bbb111
ccc222
ddd333
eee
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/multiline. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/multiline/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Multiline project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kirikak2/multiline/blob/master/CODE_OF_CONDUCT.md).
