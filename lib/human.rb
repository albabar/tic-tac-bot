require_relative 'player'

class Human < Player
  attr_reader :board

  def take_move(board)
    @board = board
    board.mark ask_move, sign
  end

  private
    def ask_move
      print "#{name} choose your move: "
      evaluate_input
    end

    def evaluate_input
      move = gets.chomp.downcase
      if move == 'quit' || move == 'q'
        puts "\nThanks for playing. :)"
        exit
      elsif board.allow?(move.to_i)
        move.to_i
      else
        ask_move
      end
    end

end
