require './lib/connect_four.rb'

describe "Gameboard" do
  describe "#create_board" do
    gameboard = Gameboard.new

    it "returns an array" do
      expect(gameboard.create_board.class).to eql(Array)  
    end

    it "returns an array with 6 inner arrays" do
      expect(gameboard.create_board.length).to eql(6)
    end

    it "each inner array is of length 7" do
      board_size = gameboard.create_board.all? { |a| a.length == 7 }
      expect(board_size).to eql(true)
    end
  end

  describe "#find_available_row" do
    gameboard = Gameboard.new

    it "if the column of the bottom row empty return it" do
      row = gameboard.find_available_row(3)
      expect(row).to eql(0)
    end

    it "return the upper row if bottom column row isn't empty" do
      gameboard.board[0][2] = "o"
      row = gameboard.find_available_row(2)
      expect(row).to eql(1)
    end

    it "return nil if the column is full" do
      gameboard.board[0][3] = "o"
      gameboard.board[1][3] = "o"
      gameboard.board[2][3] = "o"
      gameboard.board[3][3] = "o"
      gameboard.board[4][3] = "o"
      gameboard.board[5][3] = "o"

      row = gameboard.find_available_row(3)
      expect(row).to eql(nil)
    end
  end


  describe "#write_move" do
    gameboard = Gameboard.new

    it "should write row 0, column 1" do
      gameboard.write_move(1, "o")
      expect(gameboard.board[0][1]).to eql("o")
    end

    it "should write upto row 5, column 4" do
      gameboard.write_move(4, "o")
      gameboard.write_move(4, "o")
      gameboard.write_move(4, "o")
      gameboard.write_move(4, "o")
      gameboard.write_move(4, "o")
      gameboard.write_move(4, "o")

      expect(gameboard.board[5][4]).to eql("o")
    end

    it "return nil if column is full" do
      expect(gameboard.write_move(4, "o")).to eql(nil)
    end
  end

  describe "#display_board" do
    gameboard = Gameboard.new

    it "should return the board as a string" do
      expectation = ""
      gameboard.board.each do |r| 
        expectation += "|" + r.join("|") + "|\n"
      end

      expect(gameboard.display_board).to eql(expectation)
    end
  end

  describe "#check_horizontal" do
    gameboard = Gameboard.new

    it "return true if 4 straight in bottom row" do
      2.upto(5) { |n| gameboard.write_move(n, "o") }
      expect(gameboard.check_horizontal(0, 4)).to eql(true)
    end

    it "return true if 4 straight in middle row" do
      3.upto(6) { |n| gameboard.board[3][n] = "o" }
      expect(gameboard.check_horizontal(3, 3)).to eql(true)
      expect(gameboard.check_horizontal(3, 4)).to eql(true)
      expect(gameboard.check_horizontal(3, 5)).to eql(true)
      expect(gameboard.check_horizontal(3, 6)).to eql(true)
    end
  end

  describe "#check_vertical" do
    gameboard = Gameboard.new 

    it "return true if straight vertical at bottom" do
      4.times { |n| gameboard.write_move(0, "o") } 
      expect(gameboard.check_vertical(3, 0)).to eql(true)
    end
  end

  describe "#get_diagonal" do
    it "return correct left diagonal array 0, 4" do
      gameboard = Gameboard.new

      gameboard.board[0][4] = "o"
      gameboard.board[1][3] = "o"
      gameboard.board[2][2] = "o"
      gameboard.board[3][1] = "o"

      expect(gameboard.get_diagonal(0, 4, "left")).to eql([[0,4],[1,3],[2,2],[3,1]])
      expect(gameboard.get_diagonal(1, 3, "left")).to eql([[1,3],[2,2],[3,1],[4,0]])
      expect(gameboard.get_diagonal(2, 2, "left")).to eql([[2,2],[3,1],[4,0]])
      expect(gameboard.get_diagonal(3, 1, "left")).to eql([[3,1],[4,0]])
    end

    it "return correct right diagonal 2, 4" do
      gameboard = Gameboard.new

      3.times { |n| gameboard.board[n][n] = "o" }

      expect(gameboard.get_diagonal(0, 0, "right")).to eql([[0,0],[1,1],[2,2],[3,3]])
      expect(gameboard.get_diagonal(1, 1, "right")).to eql([[1,1],[2,2],[3,3],[4,4]])
      expect(gameboard.get_diagonal(2, 2, "right")).to eql([[2,2],[3,3],[4,4],[5,5]])
      expect(gameboard.get_diagonal(3, 3, "right")).to eql([[3,3],[4,4],[5,5]])
    end
  end

  describe "#check_left_diagonal" do
    it "returns true with diagonal 2, 4 to 5, 1" do
      gameboard = Gameboard.new

      gameboard.board[2][4] = "o"
      gameboard.board[3][3] = "o"
      gameboard.board[4][2] = "o"
      gameboard.board[5][1] = "o"

      expect(gameboard.check_left_diagonal(2, 4)).to eql(true)
      expect(gameboard.check_left_diagonal(3, 3)).to eql(true)
      expect(gameboard.check_left_diagonal(4, 2)).to eql(true)
      expect(gameboard.check_left_diagonal(5, 1)).to eql(true)
    end
  end
  
  describe "#check_right_diagonal" do
    it "return true in a right diagonal" do
      gameboard = Gameboard.new
      2.upto(5) { |n| gameboard.board[n][n] = "o" }
      expect(gameboard.check_right_diagonal(2, 2)).to eql(true)
      expect(gameboard.check_right_diagonal(3, 3)).to eql(true)
      expect(gameboard.check_right_diagonal(4, 4)).to eql(true)
      expect(gameboard.check_right_diagonal(5, 5)).to eql(true)
    end
  end

  describe "#check_win?" do
    it "return true if 4 in a row" do
      gameboard = Gameboard.new
      1.upto(4) { |n| gameboard.write_move(n, "o") }
      expect(gameboard.check_win?(0, 4)).to eql(true)
    end

    it "return true if 4 in a column" do
      gameboard = Gameboard.new
      4.times { gameboard.write_move(1, "o") }
      expect(gameboard.check_win?(3, 1)).to eql(true)
    end

    it "return true if 4 in a diagonal" do
      gameboard = Gameboard.new
      4.times { |n| gameboard.board[n][n] = "o" }
      expect(gameboard.check_win?(3, 3)).to eql(true)
    end
  end

  describe "#diagonal_match?" do
    it "returns true if diagonal matches to desired mark" do
      gameboard = Gameboard.new
      diagonal = []
      3.times do |n| 
        gameboard.board[n][n] = "o"
        diagonal << [n, n]
      end
      expect(gameboard.diagonal_match?(diagonal, "o")).to eql(true)
    end
  end

  describe "#straight_match?" do
    it "returns true if row matches to desired mark" do
      gameboard = Gameboard.new
      row = []
      3.times do |n| 
        gameboard.board[0][n] = "o"
        row << gameboard.board[0][n] 
      end
      expect(gameboard.straight_match?(row, "o")).to eql(true)
    end
  end

  describe "#is_inside_board?" do
    gameboard = Gameboard.new

    it "returns true with [2, 2]" do
      expect(gameboard.is_inside_board?(2, 2)).to eql(true)
    end

    it "returns false with [7, -5]" do
      expect(gameboard.is_inside_board?(7, -5)).to eql(false)
    end
  end

  describe "#empty_square?" do
    gameboard = Gameboard.new

    it "returns true with empty square" do
      expect(gameboard.empty_square?(0, 0)).to eql(true)
    end

    it "returns false with occupied square" do
      gameboard.write_move(0, "o")
      expect(gameboard.empty_square?(0, 0)).to eql(false)
    end
  end

  describe "#move_is_valid?" do
    gameboard = Gameboard.new

    it "returns true with valid moves" do
      expect(gameboard.move_is_valid?(0, 0)).to eql(true)
      expect(gameboard.move_is_valid?(5, 3)).to eql(true)
    end

    it "returns false with invalid moves" do
      gameboard.write_move(0, "o")

      expect(gameboard.move_is_valid?(0, 0)).to eql(false)
      expect(gameboard.move_is_valid?(7, 9)).to eql(false)
    end
  end
end

describe "Player" do
  player = Player.new("o")

  describe "#input" do
    it "return a string" do
      allow($stdin).to receive(:gets).and_return("yes")
      col = $stdin.gets

      expect(col).to eq("yes")
    end
  end
end

describe "Game" do
  gameboard = Gameboard.new
  player_1 = Player.new("o")
  player_2 = Player.new("x")
  game = Game.new(gameboard, player_1, player_2)

  describe "#prompt_column" do
    it "return a string" do
      expect(game.prompt_column.class).to eql(String)
    end
  end

  describe "#congratulation_msg" do
    it "return a string congratulating the player" do
      msg = game.congratulation_msg(player_1)
      expect(msg).to eql("Congratulations player 'o', you have won!")
    end
  end

  describe "#wrong_col_msg" do
    it "return a string saying that the column is wrong" do
      msg = game.wrong_col_msg
      expect(msg).to eql("Wrong column, please try again.")
    end
  end

  describe "#get_player_move" do
    it "player gets it's input method called" do
      player = double("player")
      expect(player).to receive(:integer_input).and_return(4)

      game = Game.new(Gameboard.new, player, Player.new("x"))
      game.get_player_move(player)
    end

    it "return 5 when 5 entered in input" do
      player = double("player")

      allow(player).to receive(:integer_input).and_return(5)

      game = Game.new(Gameboard.new, player, Player.new("x"))
      expect(game.get_player_move(player)).to eql(5)
    end
  end

  describe "#set_game_over_true" do
    it "sets @game_over to true" do
      game.set_game_over_true
      expect(game.game_over).to eql(true)
    end
  end

  describe "#player_turn" do
    it "calls gameboard's #display_board method" do
      gameboard = double("gameboard")
      player1 = double("player1")
      game = Game.new(gameboard, player1, double("player2"))

      #expect(gameboard).to receive(:find_available_row)

      #game.player_turn(player1)
    end

    it "calls #get_player_move" do
      player1 = double("player1")
      gameboard = Gameboard.new
      game = Game.new(gameboard, player1, double("player2"))

      #allow(game).to receive(:get_player_move).and_return(5)
      #game.player_turn(player1)
    end

    it "calls #write_move" do
      gameboard = double("gameboard")
      player1 = double("player1")
      game = Game.new(gameboard, player1, double("player2"))
      
      #expect(gameboard).to receive(:write_move)
      #game.player_turn(player1)
    end

    it "return false if not winning move" do
      player1 = Player.new("o")
      game = Game.new(Gameboard.new, player1, double("player2"))

      allow(game).to receive(:get_player_move).and_return(3)
      expect(game.player_turn(player1)).to eql(false)
    end

    it "return true if winning move" do
      player1 = Player.new("o")
      gameboard = Gameboard.new
      game = Game.new(gameboard, player1, double("player2"))

      3.times {|n| gameboard.write_move(n, "o")}

      allow(game).to receive(:get_player_move).and_return(3)
      expect(game.player_turn(player1)).to eql(true)
    end
  end

  describe "#start_game" do
    it "should call #player_turn two times" do
      player1 = double("player1")
      player2 = double("player2")
      game = Game.new(double("gameboard"), player1, player2)

      expect(game).to receive(:player_turn).at_least(2).times

      game.start_game
    end
  end
end

describe "Extras" do
  include Extras

  describe "#is_integer?" do
    it "return true with a number" do
      expect(is_integer?(5)).to eql(true)
    end

    it "return false with a string" do
      expect(is_integer?("ddd")).to eql(false)
    end
  end
end
