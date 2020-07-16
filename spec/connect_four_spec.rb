require './connect-four'

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
end
