# The Card Game

This challenge came in two parts, however, this code represents the final code as the second part built on the first.

<br>

## The Challenge

To the best of my recollection, this was how the challenge was described:

Create a method (or methods) which accepts a number of players (default to 2), and an array of integers which represent numbers in a deck of cards. The method should start at the back (or top) of the deck, removing one card for each player, each round, until you run out of cards. Each round, the player who gets the highest numbered card wins that round. The player with the greatest number of wins, wins the card game. A message should be displayed showing who won the game and the total number of wins.

Example: You have 2 players and a deck of cards represented as `cards = [1, 2, 4, 3, 5, 6]`.

#### Round 1

player 1 gets `6`, player 2 gets `5`. **Player 1 wins**.

#### Round 2

player 1 gets `3`, player 2 gets `4`. **Player 2 wins**.

#### Round 3

player 1 gets `2`, player 2 gets `1`. **Player 1 wins**.

#### End Result

`Player 1 wins, winning 2 times`


<br>

## Challenge Notes

The first code test in this challenge only provided 5 integers in the card deck (the array). If I was to pull 2 cards for each round, I was going to be short a card on the 3rd round. I was left to assume that if there weren't any cards left (or there weren't enough cards for each play in the final round), the user(s) who didn't have cards ended up with a `0` for that round.

## My Solution

```ruby
require 'test/unit'

def card_game(players: 2, cards:)
  total_rounds = (cards.size / players.to_f).ceil
  rounds = total_rounds.times.map { players.times.map { cards.pop || 0 } }
  wins = Array.new(players, 0)

  rounds.each do |round|
    round_winners = indexes_with_max_value(round)
    round_winners.each { |i| wins[i] += 1 }
  end

  determine_winner(wins)
end

def determine_winner(wins)
  winning_max_times = "winning #{wins.max} times"
  game_winners = indexes_with_max_value(wins)

  if game_winners.size > 1
    last = game_winners.pop
    players = "#{game_winners.map { |i| i + 1 }.join(', ')} and #{last + 1}"
    "There was a tie between Players #{players}, each #{winning_max_times}"
  else
    "Player #{game_winners[0] + 1} wins, #{winning_max_times}"
  end
end

def indexes_with_max_value(array)
  return [] if array.max == 0
  array.each_with_index.select { |e, i| e == array.max }.map(&:last)
end

class TestCardGame < Test::Unit::TestCase
  def test_should_return_player_1_wins
    cards = [7, 3, 7]
    assert_equal 'Player 1 wins, winning 2 times', card_game(cards: cards)
  end

  def test_should_return_player_2_wins
    cards = [7, 3, 7, 3]
    assert_equal 'Player 2 wins, winning 2 times', card_game(cards: cards)
  end

  def test_should_return_a_tie_for_2_players
    cards = [7, 3, 3, 7, 5, 1, 1, 5]
    message = 'There was a tie between Players 1 and 2, each winning 2 times'
    assert_equal message, card_game(cards: cards)
  end

  def test_should_return_player_5_wins
    cards = [10, 2, 3, 3, 5, 3, 2, 2, 1, 2]
    assert_equal 'Player 5 wins, winning 2 times', card_game(players: 5, cards: cards)
  end

  def test_should_return_player_tie_for_3_players
    cards = [1, 2, 2, 2, 1, 2, 3, 3, 1, 3, 2, 2]
    message = 'There was a tie between Players 1, 2 and 3, each winning 2 times'
    assert_equal message, card_game(players: 4, cards: cards)
  end
end

```

<br>

### Running the Code

You can clone the repo and run the file as described below, or you can create a file named `card_game.rb`, copy the contents of the code snippet to the file and save. Run the following in the console:

```sh
$ ruby card_game.rb
```

You should see the following:

```sh
➜ ruby card_game.rb
Loaded suite card_game
Started
.....
Finished in 0.00083 seconds.
---------------------------------------------------------------------------------------
5 tests, 5 assertions, 0 failures, 0 errors, 0 pendings, 0 omissions, 0 notifications
100% passed
---------------------------------------------------------------------------------------
6024.10 tests/s, 6024.10 assertions/s
```
