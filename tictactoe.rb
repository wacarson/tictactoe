#Issues to fix
#Control c is error
#Entering A4 etc is error
#Entering nothing is error

#TO DO
#Split classes into files

class Board
  attr_accessor :board_s, :board, :spot_locator
  def initialize
	@board_s =  "   A   B   C\n1 ___|___|___\n2 ___|___|___\n3    |   |  "
	@board = Array.new(3, "") {Array.new(3, "")}
    @spot_locator = [[16, 20, 24],   [30, 34, 38],   [44, 48, 52]] 
  end

  def update
    @board.each_with_index do |row, row_i|
      row.each_with_index do |square, column_i|
		spot = @board[row_i][column_i]
		string_loc = @spot_locator[row_i][column_i]
        @board_s[string_loc] = spot unless spot == ''
      end  
	end
  end

end



class GameState
  attr_reader :game_over, :player_turn
  def initialize
    @game_over = false
	@player_turn = "X"
    @turn_count = 0
  end

  def change_turn
	if @player_turn == "X"
        @player_turn = "O"
	else
		@player_turn = "X"
	end
	@turn_count += 1
  end

  def check(square, board)
	result = true

	result = false unless square.length == 2
    column = square[0].upcase.ord - 65
    row = square[1].to_i - 1
    spot = board.board[row][column]
	result = self.check_location(column, row) if result
    if spot == '' and result
	  board.board[row][column] = player_turn
	  board.update
	  result = true
	  return result
    end
	puts "Invalid entry. Try again"
	result = false
  end

  def check_location(column, row)
    if row > 2 or row == -1 or column > 2 or column < 0
      return false
    end
	return true
  end

  def check_rows(board)
    board.board.each do |row|
      if row[0] == row[1] and row[0] == row[2] and row[0] != ""
        return true
      end
    end
    return false
  end

  def check_columns(board_obj)
    board = board_obj.board
    i = 0
    for row in board
      if board[0][i] != ""
        if board[0][i] == board[1][i] and board[0][i] == board[2][i]
          return true
        end
      end
      i += 1
    end
    return false
  end

  def check_diagnols(board_obj)
    result = false
	board = board_obj.board
    if board[0][0] == board[1][1] and board[0][0] == board[2][2] and board[0][0] != ""
      result = true
    elsif board[0][2] == board[1][1] and board[0][2] == board[2][0] and board[0][2] != ""
      result = true
    end
	return result
  end

  def check_end(board)
    if check_rows(board) or check_diagnols(board) or check_columns(board)
      @game_over = true
	  puts board.board_s
      puts "Game over! Player #{@player_turn} wins!"
	elsif @turn_count == 9
	  @game_over = true
	  puts board.board_s
      puts "It's a draw!"
    end
  end

end

class TicTacToe
  board = Board.new()
 # players = {"X": Player.new('X'), "O": Player.new('O')}
  game = GameState.new()
  i = 0
  puts "Welcome to tic-tac-toe. Each player will choose a square by column and row, e.g., A2"

  until game.game_over
	puts board.board_s
  #  puts players[game.player_turn].name + ": choose a square"
	puts "Player #{game.player_turn}: choose a square"
	square = gets.chomp
	puts ""
    valid = game.check(square, board)
    game.check_end(board)
	game.change_turn if valid
  end
end

#   A   B   C
#1 ___|___|_O_
#2 ___|___|_X_
#3    |   | O

game = TicTacToe.new()
