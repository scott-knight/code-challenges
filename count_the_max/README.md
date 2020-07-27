# Count the Max

Code Challenge: create a method which parses an array of values and adds counts to cells in a two-dimensional grid. Once the parsing is complete, the method shoould find the total number of cells which contain the max value.

For example, the following array contains a set of numbers separated by empty space.

```ruby
["1 4", "3 2", "4 2"]
```

The first number in each set represents the number of rows to be affected. The second number is the number of columns to be affected. The goal is run through each set of numbers, incrementing each row's column's by the numbers represented in each set

For example, the first set is `1 4`, which is 1 row and 4 columns. Increment each column, in the first row, by 1.

| 0 | 0 | 0 | 0 |
| --- | --- | --- | --- |
| **0** | **0** | **0** | **0** |
| **0** | **0** | **0** | **0** |
| _**1**_ | _**1**_ | _**1**_ | _**1**_ |

The next set is `3 2`. Increment the first 2 columns, in 3 rows, by 1.

| 0 | 0 | 0 | 0 |
| --- | --- | --- | --- |
| _**1**_ | _**1**_ | **0** | **0** |
| _**1**_ | _**1**_ | **0** | **0** |
| _**2**_ | _**2**_ | _**1**_ | _**1**_ |

The next set is `4 2`. Increment the first 2 columns, in 4 rows, by 1.

| _1_ | _1_ | 0 | 0 |
| --- | --- | --- | --- |
| _**2**_ | _**2**_ | **0** | **0** |
| _**2**_ | _**2**_ | **0** | **0** |
| _**3**_ | _**3**_ | _**1**_ | _**1**_ |

After running through each set in the array, calculate how many cells in the grid contain the max value. In this example, `3` is the max value found in `2` cells. The method should return `2`.

Create a method that parses and array as described and finds the max number of cells with the largest value.

## My Solution

```ruby
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
```
<br>

### Running the Code

You can clone the repo and run the file as described below, or you can create a file named `count_the_max.rb`. copy the contents of the code snippet to the file and save. Run the following in the console:

```sh
$ ruby count_the_max.rb
```

You should see the following:

```sh
➜ ruby count_the_max.rb
Loaded suite count_the_max
Started
.
Finished in 0.000647 seconds.
-----------------------------------------------------------------------------------------
1 tests, 4 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
100% passed
-----------------------------------------------------------------------------------------
1545.60 tests/s, 6182.38 assertions/s
```
