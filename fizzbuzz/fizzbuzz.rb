def fizz_buzz(n)
  (1..n).each do |i|
    output = []
    output << 'Fizz' if i % 3 == 0
    output << 'Buzz' if i % 5 == 0
    output << i if output.empty?
    puts output.join('')
  end
end