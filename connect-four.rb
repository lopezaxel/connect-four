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
end

class Player
 def prompt_column
   "Enter a column: "
 end

 def input
   gets.chomp
 end
end

gameboard = Gameboard.new
player = Player.new

