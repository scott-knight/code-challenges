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