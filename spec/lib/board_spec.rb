describe Board do
  let(:board) { Board.new }
  let(:positions) { (1..9).to_a }

  it 'records a move' do
    move = board.mark(5, 'X')
    expected_board = positions
    expected_board[4] = 'X'

    expect(move).to eq('X')
    expect(board.positions).to eql(expected_board)
  end

  it 'returns all available moves' do
    board.mark(7, 'X')
    board.mark(4, 'O')
    expect(board.possible_moves).to eql(positions - [4, 7])
  end

  it 'only starts with X' do
    board.mark(4, 'X')
    expect(board.possible_moves).to eql(positions - [4])
  end

  it 'does not start with O' do
    board.mark(4, 'O')
    expect(board.possible_moves).to eql(positions)
  end

  it 'does not accept repeated move' do
    board.mark(4, 'X')
    board.mark(3, 'O')
    board.mark(8, 'O')
    expect(board.possible_moves).to eql(positions - [3, 4])
  end

  describe '#allow?' do
    it { expect(board.allow?(7)).to be true }
    it { expect(board.allow?(12)).to be false }
  end

  describe '#full?' do
    it do
      9.times do |i|
        board.mark(i+1, 'X')
        board.mark(i+2, 'O')
      end

      expect(board.full?).to be true
      expect(board.game_over?).to be true
      expect(board.drawn?).to be true
    end
  end

  it 'should win for X' do
    board.mark(1, 'X')
    board.mark(4, 'O')
    board.mark(2, 'X')
    board.mark(5, 'O')
    board.mark(3, 'X')

    expect(board.has_won?('X')).to be true
    expect(board.game_over?).to be true
  end

  describe '#dup' do
    it 'makes deep copy of board' do
      board2 = board.dup
      board2.mark 7, 'X'
      expect(board.possible_moves).not_to eq(board2.possible_moves)
    end
  end

  describe '#winning_lines' do
    it 'generates winning lines dynamically' do
      expect(board.winning_lines).to eq([[1,2,3],[4,5,6],[7,8,9],
                                                [1,4,7],[2,5,8],[3,6,9],
                                                [1,5,9],[3,5,7]])
    end

    it 'generate proper winning sequence for 4x4 board as well' do
      expect(Board.new(4).winning_lines).to eq([[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12], [13, 14, 15, 16],
                                                    [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [4, 8, 12, 16],
                                                    [1, 6, 11, 16], [4, 7, 10, 13]])
    end


    it 'generate proper winning sequence for 5x5 board as well' do
      expect(Board.new(5).winning_lines).to eq([[1, 2, 3, 4, 5], [6, 7, 8, 9, 10], [11, 12, 13, 14, 15], [16, 17, 18, 19, 20],
                                                       [21, 22, 23, 24, 25], [1, 6, 11, 16, 21], [2, 7, 12, 17, 22], [3, 8, 13, 18, 23], 
                                                       [4, 9, 14, 19, 24], [5, 10, 15, 20, 25], [1, 7, 13, 19, 25], [5, 9, 13, 17, 21]
                                                    ])
    end

  end
end
