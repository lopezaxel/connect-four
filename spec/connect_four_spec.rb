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

  describe "@board" do
    gameboard = Gameboard.new

    it "@board should be the return array from #create_method" do
      expect(gameboard.board).to eql(gameboard.create_board)
    end
  end

  describe "#write_move" do
    gameboard = Gameboard.new

  end

  describe "#find_available_row" do
    gameboard = Gameboard.new

    it "if the column of the bottom row empty return it" do
      row = gameboard.find_available_row(3)
      expect(row).to eql(0)
    end
  end
end

