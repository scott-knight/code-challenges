# How Many Times will You Get 42

## The Challenge

In a range of 1 to 1,000,000, if you were to break up each number, ie 1234, 3456, etc. into separate numbers, then add them, i.e. 1+2+3+4 = 10, how many times would you get 42?

I was asked this question in 2016. I was so taken with the challenge that I came home after the interview and wrote down the solution I found during the interview.

<br>

## My First Solution From 2016

```ruby
count = 0

(1..1000000).each { |i| x = i.to_s.split(''); count += 1 if x.inject(0){|sum,x| sum + x.to_i} == 42; };

count
```

<br>

## Update

I was recently (in 2020) interviewed for the same position with the same company. They presented me the exact same challenge. During the video interview, I did a screen share, and showed them my solution from the previous interview. We had a chuckle over the fact that I saved my code.

Interestingly, one of the devs asked me, "now that you have more experince, would I change your code to solve the problem (to get a better `Golf score`)"?

In my head, I remembered a coding mantra taught in college, "good code is code that works", forgeting that they teach that mantra to get you feeling good about the (crapy) code you produce to get a grade, I and replied that I wouldn't change the code since the code works.

<br>

## My New Solution

An hour or two after the interview, my mind was unsettled by my quick answer (as it should have been), and I started working on a new solution in my head (you know, that auto-pilot thing that happens after you have been coding for a few years). After reviewing my original solution, I quickly decided to make a significant change. This updated code runs faster, is cleaner, and I even wrote a test for it.

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

## Running the Code

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
Finished in 1.419953 seconds.
----------------------------------------------------------------------------------------
1 tests, 1 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
100% passed
----------------------------------------------------------------------------------------
0.70 tests/s, 0.70 assertions/s
```
