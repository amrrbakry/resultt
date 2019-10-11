
# Resultt
A simple library to wrap execution result in smart success or error objects.
```ruby
success_result = Result do
  1 + 1
end
# => #<Resultt::Success:0x0000000098c718 @value=2>

success_result.success? # true
success_result.value # 2
success_result.error? # false

error_result = Result do
  raise StandardError, 'error result'
end
# => #<Resultt::Error:0x000000007c5498 @error=#<StandardError: error result>>

error_result.error? # true
error_result.error # #<StandardError: error result>
```
```ruby
result = Result do
  # do something
end

case result
when Resultt::Success then 'it is a success!'
when Resultt::Error then 'oh no! error!'
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'resultt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install resultt

## Usage

extend `Resultt` in your class and you're good to go!
```ruby
class MyClass
  extend Resultt

  def foo
    Result do
      # do something
    end
  end
end
```
#### `map` and `map_error`
it is possible to map on values and errors in `Resultt` objects using `map` and `map_error` respectively:
```ruby
result = Result { 1 + 1 }
# => #<Resultt::Success:0x000000007502d8 @value=2>
mapped_result = result.map { |value| value + 1 }
# => #<Resultt::Success:0x000000007502d8 @value=3>

result = Result { raise StandardError, 'error' }
# => #<Resultt::Error:0x00000000bc8d88 @error=#<StandardError: error>>
mapped_result = result.map_error { |error| error.class.to_s }
# => #<Resultt::Error:0x00000000be6568 @error="StandardError">
```
#### `Success` and `Error`
it is also possible to wrap values or errors in `Resultt::Success` or `Resultt::Error` objects directly:
```ruby
Success('ok')
# => #<Resultt::Success:0x0000000076b718 @value="ok">
Error('err')
# => #<Resultt::Error:0x00000000764a08 @error="err">
```

### Nil values
`Result` will return `Resultt::NilValueError` if the block passed to it evaluates to `nil`. This is to avoid having success results with `nil` values.
```ruby
Result do
  nil
end
# => #<Resultt::Error:0x00000000afa000 @error=#<Resultt::NilValueError: Result returned a nil value>>
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/amrrbakry/resultt. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Resultt project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/amrrbakry/resultt/blob/master/CODE_OF_CONDUCT.md).
