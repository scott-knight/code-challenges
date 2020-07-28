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