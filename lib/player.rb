class Player
  attr_reader :name, :sign

  def initialize(name, sign)
    @name = name
    @sign = sign
    raise ArgumentError if invalid_sign?(sign)
  end

  def take_move(board)
    board.mark board.possible_moves.sample, sign
  end

  private
    def invalid_sign?(sign)
      not Board::SIGNS.include?(sign)
    end
end
