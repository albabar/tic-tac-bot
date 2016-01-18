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

  it 'take a move based on free slots' do
    board = Board.new
    expect(player.take_move(board)).to eql(player.sign)
  end

end
