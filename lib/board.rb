class Board
  def initialize
    @positions = (1..9).to_a
  end

  def to_s
    output = []
    blank_line = '     |     |'
    flat_line = '_____|_____|_____'
    @positions.each_slice(3).to_a.each_with_index do |a, i|
      output << blank_line
      output << "  #{a.join('  |  ')}  "
      if i < 2
        output << flat_line
      else
        output << blank_line
      end
    end

    output.join("\n")
  end
end
