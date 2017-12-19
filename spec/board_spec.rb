require File.expand_path("../../lib/board", __FILE__)

describe Board do
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

  describe '#legal_move?' do
    context 'given a non-existent column' do
      it 'returns false' do
        expect(board.legal_move?(7)).to eq(false)
      end
    end
    context 'passed an existing, non-full column' do
      before do
        4.times {board.place_move(6, "X")}
      end
      it 'returns true' do
        expect(board.legal_move?(6))
      end
    end
    context 'passed a full column' do
      before do
        6.times {board.place_move(4, "X")}
      end
      it 'returns false' do
        expect(board.legal_move?(4)).to eq(false)
      end

    end
  end

  describe '#next_empty_row' do
    context 'given a column containing one marker' do
      before do
        board.place_move(3, "X")
      end
      it 'returns row 4' do
        expect(board.next_empty_row(3)).to eq(4)
      end
    end
  end

    describe 'place_move' do
      context 'in an empty column' do
        it 'places the marker in the bottom row' do
          board.place_move(3, "X")
          expect(board.contents[5][3].value).to eq("X")
        end
      end
      context 'in a column already containing a marker' do
        before do
          board.place_move(3, "X")
        end
        it 'doesn\'t change the original marker' do
          board.place_move(3, "O")
          expect(board.contents[5][3].value).to eq("X")
        end
        it 'places new marker in the next empty cell' do
          board.place_move(3, "O")
          expect(board.contents[4][3].value).to eq("O")
        end
      end
    end

    describe '#update_columns' do
      it 'updates all 7 cols' do
        board.update_columns
        expect(board.columns.length).to eq(7)
      end

      it 'returns 6 elements per column' do
        expect(board.columns[0].length).to eq(6)
      end
    end

    describe '#rows' do
      it 'returns all 6 rows' do
        expect(board.rows.length).to eq(6)
      end

      it 'returns 7 elements per row' do
        expect(board.rows[5].length).to eq(7)
      end
    end



    describe '#four_in_a_row?' do
      context 'passed a winning row' do
        before do
          (0..3).each { |cell| board.place_move(cell, "X") }
        end
        it 'returns true' do
          expect(board.four_in_a_row?(board.contents[5])).to eq(true)
        end
      end
      context 'passed a winning column' do
        before do
          4.times {board.place_move(5,"O")}
        end
        it 'returns true' do
          col = (0..5).map {|i| board.contents[i][5]}
          expect(board.four_in_a_row?(col)).to eq(true)
        end
      end
      context 'passed a full but losing array' do
        before do
          3.times do
            board.place_move(2,"O")
            board.place_move(2,"X")
          end
        end
        it 'returns false' do
          col = (0..4).map {|i| board.contents[i][2]}
          expect(board.four_in_a_row?(col)).to eq(false)
        end
      end
    end
end
