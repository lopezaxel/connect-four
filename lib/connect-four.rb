require './lib/gameboard.rb'
require './lib/player.rb'

class Game
  attr_accessor :board
  attr_reader :player1, :player2

  def initialize(gameboard, player1, player2)
    @gameboard = gameboard
    @player1 = player1
    @player2 = player2
    @game_over = false
  end

  def congratulation_msg(player)
    "Congratulations player '#{player.mark}', you have won!"
  end
end

gameboard = Gameboard.new
player_1 = Player.new("o")
player_2 = Player.new("o")
game = Game.new(gameboard, player_1, player_2)

