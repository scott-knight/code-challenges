# FizzBuzz

Who hasn't created a fizzbuzz method?

## The Challenge

Write a short program that prints each number from 1 to 100 on a new line. For each multiple of 3, print "Fizz" instead of the number. For each multiple of 5, print "Buzz" instead of the number. For numbers which are multiples of both 3 and 5, print "FizzBuzz" instead of the number.

<br>

## My Solution

```ruby
require 'test/unit'
require 'stringio'

def fizz_buzz(n)
  output = []
  output << 'Fizz' if n % 3 == 0
  output << 'Buzz' if n % 5 == 0
  output << n if output.empty?
  output.join('')
end

def fizzbuzz(n)
  (1..n).each { |i| puts fizz_buzz(i) }
end

class TestFizzBuzz < Test::Unit::TestCase
  # with_captured_stdout comes from
  # https://stackoverflow.com/questions/14987362/how-can-i-capture-stdout-to-a-string
  # Author: fearless_fool
  def with_captured_stdout
    original_stdout = $stdout  # capture previous value of $stdout
    $stdout = StringIO.new     # assign a string buffer to $stdout
    yield                      # perform the body of the user code
    $stdout.string             # return the contents of the string buffer
  ensure
    $stdout = original_stdout  # restore $stdout to its previous value
  end

  def test_should_return_fizz
    assert_equal 'Fizz', fizz_buzz(3)
  end

  def test_should_return_buzz
    assert_equal 'Buzz', fizz_buzz(5)
  end

  def test_should_return_fizz_buzz
    assert_equal 'FizzBuzz', fizz_buzz(45)
  end

  def test_should_return_integer
    assert_equal '17', fizz_buzz(17)
  end

  def test_fizzbuzz_output
    result = with_captured_stdout { fizzbuzz(15) }.split(/\n+/)
    assert result.include?('FizzBuzz')
  end
end
```

<br>

### Running the Code

You can clone the repo and run the file as described below, or you can create a file named `fizzbuzz.rb`, copy the contents of the code snippet to the file and save. Run the following in the console:

```sh
$ ruby fizzbuzz.rb
```

You should see the following:

```sh
➜ ruby fizzbuzz.rb
Loaded suite fizzbuzz
Started
.....
Finished in 0.00122 seconds.
-----------------------------------------------------------------------------------------
5 tests, 5 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
100% passed
-----------------------------------------------------------------------------------------
4098.36 tests/s, 4098.36 assertions/s
```