require_relative 'player'

class Devil < Player
  def take_move(board)
    print "Wait, I'm thinking"
    15.times{print '.'; sleep(0.1)}

    if board.first_move?(sign) #Improve initial thinking
      board.mark board.possible_moves.select(&:odd?).sample, sign
    else
      board.mark think(board), sign
    end
  end

  private
    def think(board, depth=0, scores={})
      return 0 if board.drawn?
      return -1 if board.game_over?

      board.possible_moves.each do |move|
        potential_board = board.dup
        potential_board.mark(move, board.next_move)
        scores[move] = -1 * think(potential_board, depth + 1, {})
      end

      best_move, max_simulated_score = scores.max_by { |k, v| v }

      if depth == 0
        best_move
      elsif depth > 0
        max_simulated_score
      end
    end
end
