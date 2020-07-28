# How Many Times will You Get 42

## The Challenge

In a range of 1 to 1,000,000, if you were to break up each number, ie 1234, 3456, etc. into separate numbers, then add them, i.e. 1+2+3+4 = 10, how many times would you get 42?

Create a method which calcualtes how many times you will get 42 from suming each number in the of ranging from 1 to 1,000,000, then output the count.

<br>

## My Solution

```ruby
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
```

<br>

### Running the Code

You can clone the repo and run the file as described below, or you can create a file named `how_many_times_get_42.rb`, copy the contents of the code snippet to the file and save. Run the following in the console:

```sh
$ ruby how_many_times_get_42.rb
```

You should see the following:

```sh
➜ ruby how_many_times_get_42.rb
Loaded suite how_many_times_get_42
Started
.
Finished in 1.379525 seconds.
---------------------------------------------------------------------------------------------------
1 tests, 1 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
100% passed
---------------------------------------------------------------------------------------------------
0.72 tests/s, 0.72 assertions/s
```
