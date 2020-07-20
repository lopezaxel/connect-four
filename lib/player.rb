class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def input
    gets.chomp
  end

  def integer_input
    begin
      Integer(input)
    rescue
      puts "Enter a number: "
      retry
    end
  end
end

