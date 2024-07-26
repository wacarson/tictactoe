require_relative 'lib/board'
require_relative 'lib/game_state'

# A game of tic tac toe between two human players. Class starts game and loops
class TicTacToe
  board = Board.new
  game = GameState.new
  puts 'Welcome to tic-tac-toe. Each player will choose a square by column and row, e.g., A2'

  until game.game_over
    puts board.board_s
    puts "Player #{game.player_turn}: choose a square"
    begin
      square = gets.chomp
    rescue Interrupt
      puts "\nGame quit. Goodbye."
      game.over
    else
      puts ''
      valid = game.check(square, board)
      game.check_end(board)
      game.change_turn if valid
    end
  end
end

#   A   B   C
# 1 ___|___|_O_
# 2 ___|___|_X_
# 3    |   | O

TicTacToe.new
