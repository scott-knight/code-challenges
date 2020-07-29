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
    cards = [0, 3, 7, 3, 5]
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