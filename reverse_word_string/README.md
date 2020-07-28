# Reverse Word String

## The Challenge

Take a string, revese the words in the string but maintain their location in the string, including saving the whitespace.

Requirements:

  1. Create a method that reverses a string. Don't use the Ruby method `reverse`, figure out another way to do it.
  2. Create a method which uses the word reversing method and returns the reversed string.
  3. The words have to be reversed in the original location of the original string. Meaning, simply reversing the entire string is not the point of the exercise. For example: the string `I like dogs` should be returned as `I ekil sgod`

<br>

## My Solution

```ruby
require "test/unit"

def reverse_string(input)
  input.chars.reverse_each.map { |i| i }.join
end

def reverse_word_string(string)
  array = string.scan(/\w+|\W+/)
  array.map { |word| reverse_string(word) }.join
end

class TestReverseWordString < Test::Unit::TestCase
  def test_should_return_the_correct_simple_reversed_word_string
    example = 'I like dogs'
    reversed = 'I ekil sgod'
    assert_equal reversed, reverse_word_string(example)
  end

  def test_should_return_the_correct_complex_reversed_word_string
    example = 'This       is     an            Example  of keeping  the    whitespace   '
    reversed = 'sihT       si     na            elpmaxE  fo gnipeek  eht    ecapsetihw   '
    assert_equal reversed, reverse_word_string(example)
  end
end
```

<br>

### Running the Code

You can clone the repo and run the file as described below, or you can create a file named `reverse_word_string.rb`, copy the contents of the code snippet to the file and save. Run the following in the console:

```sh
$ ruby reverse_word_string.rb
```

You should see the following:

```sh
➜ ➜ ruby reverse_word_string.rb
Loaded suite reverse_word_string
Started
..
Finished in 0.000524 seconds.
-----------------------------------------------------------------------------------------
2 tests, 2 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
100% passed
-----------------------------------------------------------------------------------------
3816.79 tests/s, 3816.79 assertions/s
```
