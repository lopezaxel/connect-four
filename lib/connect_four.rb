require './lib/gameboard.rb'
require './lib/player.rb'

class Game
  attr_accessor :gameboard, :game_over
  attr_reader :player1, :player2

  def initialize(gameboard, player1, player2)
    @gameboard = gameboard
    @player1 = player1
    @player2 = player2
    @game_over = false
  end

  def start_game
#    until game_over
    player_turn(player1)
#    break if game_over
    player_turn(player2)
#    end
  end

  def player_turn(player)
    column = get_player_move(player)
    row = gameboard.find_available_row(column)

    gameboard.write_move(column, player.mark)
    puts gameboard.display_board

    if gameboard.check_win?(row, column)
      set_game_over_true 
    else
      false
    end
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

  def set_game_over_true
    self.game_over = true
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
player_2 = Player.new("x")
game = Game.new(gameboard, player_1, player_2)
#game.start_game

