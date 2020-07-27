# FizzBuzz

Who hasn't completed a fizzbuzz code challenge?

## The Challenge

Write a method that prints each number from 1 to 100 on a new line. For each multiple of 3, print `Fizz` instead of the number. For each multiple of 5, print `Buzz` instead of the number. For numbers which are multiples of both 3 and 5, print `FizzBuzz` instead of the number.

<br>

## My Solution

```ruby
def fizz_buzz(n)
  (1..n).each do |i|
    output = []
    output << 'Fizz' if i % 3 == 0
    output << 'Buzz' if i % 5 == 0
    output << i if output.empty?
    puts output.join('')
  end
end
```
