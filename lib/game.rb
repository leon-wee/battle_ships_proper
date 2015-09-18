require_relative 'player'

class Game

  attr_reader :player1, :player2

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end

  def start_game
    puts 'Let the Battleships game begin!'
    while true
      puts 'Player 1:'
      player_1_target = gets.chomp.upcase
      puts player2.fire(player_1_target)
      break 'Player 1 Wins!' if player2.board.all_ships_sunk?
      puts 'Player 2:'
      player_2_target = gets.chomp.upcase
      puts player1.fire(player_2_target)
      break 'Player 2 Wins!' if player1.board.all_ships_sunk?
    end
  end

end