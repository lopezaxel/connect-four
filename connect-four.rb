class Gameboard
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    Array.new(6) { Array.new(7, "") }
  end
end
