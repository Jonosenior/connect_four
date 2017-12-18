require File.expand_path("../../lib/board", __FILE__)

describe Board do
  context "is initialized" do
    subject(:board) { Board.new }

    describe '#contents' do
      it 'returns an array 6 elements' do
        expect(board.contents.count).to eq(6)
      end
      it 'has 7 elements in each row' do
        expect(board.contents[5].count).to eq(7)
      end
      it 'returns a value of '' in each position on the grid' do
        expect(board.contents.each {|a| a.all? {|b| b.value == ''}})
      end
    end
  end

end
