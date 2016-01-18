class Board

  attr_reader :positions
  SIGNS = ['X', 'O']

  def initialize
    @positions = (1..9).to_a
    @next_move = 'X'
  end

  def mark(position, sign)
    if valid?(position, sign)
      @next_move = alter_sign(sign)
      @positions[position - 1] = sign
    end
  end

  def possible_moves
    @positions - SIGNS
  end

  def to_s
    output = []
    blank_line = '     |     |'
    flat_line = '_____|_____|_____'

    @positions.each_slice(3).each_with_index do |a, i|
      output << blank_line
      output << "  #{a.join('  |  ')}  "
      output << ((i < 2)? flat_line : blank_line)
    end

    output.join("\n")
  end

  private
    def valid?(position, sign)
      possible_moves.include?(position) && SIGNS.include?(sign) && @next_move == sign
    end

    def alter_sign(sign)
      ('X' == sign)? 'O' : 'X'
    end
end
