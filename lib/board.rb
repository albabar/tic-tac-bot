class Board

  attr_reader :positions, :next_move, :format, :winning_lines
  SIGNS = ['X', 'O']

  def initialize(format = 3)
    @format = format
    @positions = (1..(format**2)).to_a
    @next_move = 'X'

    @winning_lines = calculate_winning_lines
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

  def first_move?(sign)
    positions.count(sign) == 0
  end

  def has_won?(sign)
    winning_lines.any? do |line|
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
    max_length = @positions.size.to_s.size
    single_cell = '     ' + ' ' * (max_length -1)
    blank_line = ([single_cell] * format).join('|')
    flat_line = blank_line.gsub(' ', '_')
    last_index = format - 1

    rows.each_with_index do |a, i|
      output << blank_line
      output << "  #{a.map{|n| n.to_s.rjust(max_length, ' ')}.join('  |  ')}  "
      output << ((i < last_index)? flat_line : blank_line)
    end

    output.join("\n")
  end

  def diagonals
    d1 = ([1] * format).map.with_index{|n, i| 1+(i*(1+format))}
    d2 = ([format] * format).map.with_index{|n, i| format+(i*(format-1))}
    [d1, d2]
  end

  private
    def valid?(position, sign)
      allow?(position) && SIGNS.include?(sign) && @next_move == sign
    end

    def alter_sign(sign)
      ('X' == sign)? 'O' : 'X'
    end

    def rows
      @positions.each_slice(format).to_a
    end

    def calculate_winning_lines
      cols = rows[0].map{|n| ([n]*format).map.with_index{|x, i| n+(i*format)}}

      rows + cols + diagonals
    end


    def initialize_dup(other)
      super(other)
      @positions = other.positions.dup
    end
end
