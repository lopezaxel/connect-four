class Gameboard
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    Array.new(6) { Array.new(7, "") }
  end

  def find_available_row(column)
    board.each_index do |row|
      return row if board[row][column] == ""
    end

    nil
  end

  def write_move(column, mark)
    row = find_available_row(column)
    return nil if row.nil?

    board[row][column] = mark
  end
end

#gameboard = Gameboard.new

