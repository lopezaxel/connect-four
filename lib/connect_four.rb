require './lib/gameboard.rb'
require './lib/player.rb'

class Game
  attr_accessor :gameboard
  attr_reader :player1, :player2

  def initialize(gameboard, player1, player2)
    @gameboard = gameboard
    @player1 = player1
    @player2 = player2
    @game_over = false
  end

  def get_player_move(player)
    loop do
      puts prompt_column
      column = player.integer_input
      row = gameboard.find_available_row(column)

      return column if gameboard.move_is_valid?(row, column)
      puts wrong_col_msg
    end
  end

  def congratulation_msg(player)
    "Congratulations player '#{player.mark}', you have won!"
  end

  def prompt_column
    "Enter a column: "
  end

  def wrong_col_msg
    "Wrong column, please try again."
  end
end

gameboard = Gameboard.new
player_1 = Player.new("o")
player_2 = Player.new("o")
game = Game.new(gameboard, player_1, player_2)

