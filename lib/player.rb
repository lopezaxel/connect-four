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

  def is_integer?(value)
    value.is_a?(Integer)
  end
end

