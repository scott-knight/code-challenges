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

The test code for the first test only provided 5 integers in the card deck (the array). If I was to pull 2 cards for each round, I was going to be short a card on the 3rd round. I was left to assume that if there weren't any cards left (or there weren't enough cards for each play in the final round), the user(s) who didn't have cards ended up with a `0` for that round.

## My Solution

```ruby
require "test/unit"

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
