require 'stringio'

describe Human do
  let(:board) {Board.new}
  let(:human) {Human.new('Tara', 'X')}

  it 'asks and retrive move' do
    mgets '6'
    expect(human.take_move(board)).to eq('X')
    expect(board.possible_moves).to eq((1..9).to_a - [6])
  end


#  it 'asks repeteadly if valid input not given' do
#    mgets 'mula'
#    human.take_move(board)
#    expect(board.possible_moves).to eq((1..9).to_a)
#    mgets '7'
#    expect(board.possible_moves).to eq((1..9).to_a - [7])
#  end

  it 'quit cleanly with quit command' do
    mgets 'quit'
    expect(human.take_move(board)).to raise_exception(SystemExit)
  end


  def mgets(str)
    allow_any_instance_of(Kernel).to receive(:gets).and_return str
  end
end
