describe Game do
  describe '#play' do
    it 'receives #play message' do
      expect(Game.new).to respond_to(:play)
    end
  end
end
