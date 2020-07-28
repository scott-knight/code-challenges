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
    assert_equal '1',        result[0]
    assert_equal '2',        result[1]
    assert_equal 'Fizz',     result[2]
    assert_equal '4',        result[3]
    assert_equal 'Buzz',     result[4]
    assert_equal 'Fizz',     result[5]
    assert_equal '7',        result[6]
    assert_equal '8',        result[7]
    assert_equal 'Fizz',     result[8]
    assert_equal 'Buzz',     result[9]
    assert_equal '11',       result[10]
    assert_equal 'Fizz',     result[11]
    assert_equal '13',       result[12]
    assert_equal '14',       result[13]
    assert_equal 'FizzBuzz', result[14]
  end

  private

  # This method comes from, Author: fearless_fool
  # https://stackoverflow.com/questions/14987362/how-can-i-capture-stdout-to-a-string
  def with_captured_stdout
    original_stdout = $stdout # capture previous value of $stdout
    $stdout = StringIO.new    # assign a string buffer to $stdout
    yield                     # perform the body of the user code
    $stdout.string            # return the contents of the string buffer
  ensure
    $stdout = original_stdout # restore $stdout to its previous value
  end
end