require "test/unit"

def how_many_times_get_42
  count = 0

  (1..1000000).each { |i| count += 1 if i.to_s.chars.map(&:to_i).sum == 42 }

  count
end

class TestHowManyTimesGet42 < Test::Unit::TestCase
  def test_should_return_the_correct_count
    assert_equal 6062, how_many_times_get_42
  end
end
