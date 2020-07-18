require 'pry'

class Gameboard
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    Array.new(6) { Array.new(7, " ") }
  end

  def find_available_row(column)
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

  def check_horizontal(row, col)
    right = 0
    mark = board[row][col]

    return false if mark.nil?

    3.downto(0) do |left|
      next if (col - left < 0) || (col + right > board.size) 

      squares = board[row][col - left, col + right]   
      right += 1

      return true if straight_match(squares, mark) && squares.size >= 3
    end

    false
  end

  def check_vertical(row_num, col_num)
    mark = board[row_num][col_num]

    return false if (row_num - 3) < 0 || mark.nil?

    column = []
    row_num.downto(row_num - 3) do |row|
      column << board[row][col_num]
    end
    
    return straight_match(column, mark)
  end

  def get_diagonal(row, col, direction)
    diagonal = []

    row.upto(row + 3) do |r|
      unless diagonal.size == 4 || r < 0 || r > 5 || col < 0 || col > 6 
        diagonal << [r, col] 
      end

      if direction == "left"
        col += 1 
      elsif direction == "right"
        col -= 1
      end
    end

    diagonal
  end

  def check_diagonal(row, col)
    c = col - 3
    mark = board[row][col]

    return false if mark.nil?

    (row - 3).upto(row + 3) do |r|
      left_diagonal = get_diagonal(r, c, "left")
      right_diagonal = get_diagonal(r, c, "right")

      if left_diagonal.size == 4
        return true if diagonal_match(left_diagonal, mark)
      elsif right_diagonal.size == 4
        return true if diagonal_match(right_diagonal, mark)
      end

      c += 1
    end

    false
  end

  def diagonal_match(line, mark)
    line.all? { |row, col| board[row][col] == mark }
  end

  def straight_match(line, mark)
    line.all? { |square| square == mark }
  end
end

class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def prompt_column
    "Enter a column: "
  end

  def input
    gets.chomp
  end
end

gameboard = Gameboard.new
player = Player.new("o")

