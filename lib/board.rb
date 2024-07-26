# The board class for tic tac toe. Controls the string printed on screen
class Board
  attr_accessor :board_s, :board, :spot_locator

  def initialize
    @board_s = "   A   B   C\n1 ___|___|___\n2 ___|___|___\n3    |   |  "
    @board = Array.new(3, '') { Array.new(3, '') }
    @spot_locator = [[16, 20, 24], [30, 34, 38], [44, 48, 52]]
  end

  def update
    @board.each_with_index do |row, row_i|
      row.each_with_index do |_square, column_i|
        spot = @board[row_i][column_i]
        string_loc = @spot_locator[row_i][column_i]
        @board_s[string_loc] = spot unless spot == ''
      end
    end
  end
end
