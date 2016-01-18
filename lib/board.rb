class Board

  attr_reader :positions
  SIGNS = ['X', 'O']
  WIN_LINES = [[1,2,3],[4,5,6],[7,8,9],
               [1,4,7],[2,5,8],[3,6,9],
               [1,5,9],[3,5,7]]

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

  def allow?(move)
    possible_moves.include?(move)
  end

  def full?
    possible_moves.empty?
  end

  def has_won?(sign)
    WIN_LINES.any? do |line|
      line.all? {|position| @positions[position-1] == sign}
    end
  end

  def game_over?
    full? || has_won?('X') || has_won?('O')
  end

  def drawn?
    full? && (!has_won?('X') || !has_won?('O'))
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
      allow?(position) && SIGNS.include?(sign) && @next_move == sign
    end

    def alter_sign(sign)
      ('X' == sign)? 'O' : 'X'
    end
end
