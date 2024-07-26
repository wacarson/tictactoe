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

  def check_quit(letter)
    if letter.upcase == "Q"
	  @game_over = true 
      puts "Game quit. Goodbye."
      return true
    end
    return false
  end

  def check(square, board)
	return false if square == ""
    return if check_quit(square[0])
	result = true
	result = false unless square.length == 2

    column = square[0].upcase.ord - 65
    row = square[1].to_i - 1
	result = check_location(column, row) if result
    spot = board.board[row][column] if result

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


  def over
    @game_over = true
  end

end
