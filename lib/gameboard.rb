module Extras
  def is_integer?(value)
    value.is_a?(Integer)
  end
end

class Gameboard
  include Extras

  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    Array.new(6) { Array.new(7, " ") }
  end

  def find_available_row(column)
    return if column.nil?

    board.each_index do |row|
      return row if board[row][column] == " "
    end

    nil
  end

  def write_move(column, mark)
    row = find_available_row(column)
    return nil if row.nil?

    board[row][column] = mark
  end

  def display_board
    graphic = ""
    board.reverse.each do |row|
      graphic += "|#{row.join("|")}|\n"
    end

    graphic
  end

  def check_win?(row, column)
    check_horizontal(row, column) || check_vertical(row, column) ||
    check_left_diagonal(row, column) || check_right_diagonal(row, column)
  end
  
  def check_horizontal(row, col)
    right = 0
    mark = board[row][col]

    return false if mark.nil?

    3.downto(0) do |left|
      next if (col - left < 0) || (col + right > board.size) 

      squares = board[row][col - left..col + right]   
      right += 1

      return true if straight_match?(squares, mark) && squares.size > 3
    end

    false
  end

  def check_vertical(row_num, col_num)
    mark = board[row_num][col_num]

    return false if (row_num - 3) < 0 

    column = []
    row_num.downto(row_num - 3) do |row|
      square = board[row][col_num]
      column << square
    end
    
    return straight_match?(column, mark)
  end

  def get_diagonal(row, col, direction)
    diagonal = []

    row.upto(row + 3) do |r|
      break if r < 0 || r >= board.length || col < 0 || col >= board[0].length 

      diagonal << [r, col] 

      if direction == "right"
        col += 1 
      elsif direction == "left"
        col -= 1
      end
    end

    diagonal
  end

  def check_left_diagonal(row, col)
    c = col + 3
    mark = board[row][col]

    (row - 3).upto(row + 3) do |r|
      diagonal = get_diagonal(r, c, "left")
      c -= 1

      return true if diagonal_match?(diagonal, mark) && diagonal.size == 4
    end

    false
  end

  def check_right_diagonal(row, col)
    c = col - 3
    mark = board[row][col]

    (row - 3).upto(row + 3) do |r|
      diagonal = get_diagonal(r, c, "right")
      c += 1

      return true if diagonal_match?(diagonal, mark) && diagonal.size == 4
    end

    false
  end

  def diagonal_match?(line, mark)
    line.all? { |row, col| board[row][col] == mark }
  end

  def straight_match?(line, mark)
    line.all? { |square| square == mark }
  end

  def is_inside_board?(row, column)
    return if row.nil? || column.nil?
    row >= 0 && row < board.size && column >= 0 && column < board.first.size 
  end

  def empty_square?(row, column)
    board[row][column] == " "
  end

  def move_is_valid?(row, column)
    is_inside_board?(row, column) && empty_square?(row, column)
  end
end

