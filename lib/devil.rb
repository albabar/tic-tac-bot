require_relative 'player'

class Devil < Player

  def take_move(board)
    print "Wait, I'm thinking"
    20.times{print '.'; sleep(0.1)}
    super(board)
  end
end
