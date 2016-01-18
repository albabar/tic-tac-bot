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
end
