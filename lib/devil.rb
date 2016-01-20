require_relative 'player'

class Devil < Player
  def take_move(board)
    print "Wait, I'm thinking"
    15.times do
      print '.'
      sleep(0.1) if board.format == 3
    end

    if board.first_move?(sign) #Improve initial thinking
      board.mark (board.possible_moves & board.diagonals.flatten).sample, sign
    else
      board.mark think(board, 0, {}, (Float::INFINITY * -1), Float::INFINITY, 1, 0), sign
    end
  end

  private
    def think(board, depth=0, scores={}, a, b, child_level, start_level)
      return 0 if board.drawn?
      return -1 if board.game_over?

      old_child_level = child_level
      child_level = 0
      beta = b

      board.possible_moves.each do |move|
        return 0 if (start_level + 5) < depth
        child_level += 1 

        potential_board = board.dup
        potential_board.mark(move, board.next_move)

        score = -1 * think(potential_board, depth + 1, {}, -beta, -a, child_level, start_level)
        if (a < score && score < b && old_child_level != 1)
          score = -1 * think(potential_board, depth + 1, {}, -b, -a, child_level, start_level)
        end

        a = [score, a].max
        b = a + 1
        
        scores[move] = a
        break if a >= b
      end


      if depth == 0
        scores.max_by { |k, v| v }[0]
      else
        a
      end
    end

end
