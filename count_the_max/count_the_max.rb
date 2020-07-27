require "test/unit"

def count_the_max(up_right)
  ranges = up_right.map { |ur| ur.split(' ') }
  r_max  = ranges.map { |r| r[0].to_i }.max
  c_max  = ranges.map { |r| r[1].to_i }.max
  tda    = (0..r_max-1).map { |a| (0..c_max).map { 0 } }

  ranges.each do |range|
    (0..(range[0].to_i - 1)).each do |row|
      (0..(range[1].to_i - 1)).each { |col| tda[row][col] += 1 }
    end
  end

  tda.map { |i| i.select { |r| r == tda.map { |a| a.max }.max } }.flatten.size
end

class TestCountTheMax < Test::Unit::TestCase
  def test_should_return_the_correct_counts
    assert_equal 2, count_the_max(["2 3", "3 7", "4 1"])
    assert_equal 4, count_the_max(["2 3", "3 4", "4 2"])
    assert_equal 4, count_the_max(["3 5", "4 2", "2 6", "2 4"])
    assert_equal 3, count_the_max(["7 5", "1 3", "2 6", "2 4", "1 7"])
  end
end