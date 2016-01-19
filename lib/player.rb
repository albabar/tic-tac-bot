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

    def opponent_sign(sign = nil)
      sign = self.sign if sign.nil?
      (Board::SIGNS - [sign])[0]
    end
end
