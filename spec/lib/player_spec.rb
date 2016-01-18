describe Player do
  let (:player) {Player.new('Rb', 'X')}

  it 'has a name' do
    expect(player.name).to eq('Rb') 
  end

  it 'has a valid sign' do
    expect(Board::SIGNS).to include(player.sign)
  end

  it 'raise error with invalid sign' do
    expect{Player.new('Rb', 'L')}.to raise_error(ArgumentError)
  end

  it 'choose a move based on free slots' do
    board = Board.new
    expect((1..9).to_a).to include(player.take_move(board.possible_moves))
  end

end
