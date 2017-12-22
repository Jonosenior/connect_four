require_relative 'cell'


class Board
  attr_reader :contents, :rows, :columns, :diagonals

  def initialize
    @contents = Array.new(6){Array.new(7) {Cell.new}}
  end

  def visualise
    divider = "+-----+-----+-----+-----+-----+-----+-----+"
    @contents.each do |row|
        print "\n"
        puts divider
          row.each do |cell|
              print "|  #{cell.value}  "
          end
          print "|"
     end
     print "\n"
     puts "#{divider}"
     print "   0     1     2     3     4     5     6\n\n"
  end


  def place_move(col, marker)
    @contents[lowest_empty_row(col)][col].value=(marker)
  end

  def lowest_empty_row(col)
    (0..5).to_a.reverse.each do |row|
      return row if @contents[row][col].value == " "
    end
  end

  def legal_move?(col)
    col = Integer col rescue false
    return false if !(0..6).include?(col)
    whole_col = (0..5).map {|row| @contents[row][col]}
    return false if whole_col.none? {|cell| cell.value == " "}
    true
  end

  def four_in_a_row?(arr)
    pointer_value = arr[0].value
    running_total = 1
    arr.each_with_index do |cell, index|
      next if index == 0
      if cell.value == pointer_value
        running_total += 1 unless cell.value == ' '
      else
        pointer_value = cell.value
        running_total = 1
      end
      return true if running_total > 3
    end
    false
  end

  def win?
    @lines_to_check.each { |line| return true if four_in_a_row?(line) }
    false
  end

  def tie?
    @lines_to_check.each { |line| return false if line.any? {|cell| cell.value == ' '} }
    true
  end

  def update_lines_to_check
    @lines_to_check = @rows + @columns + @diagonals
  end

  def update_rows
    @rows = @contents
  end

  def update_columns
    @columns = (0..6).map {|i|(0..5).map {|j| contents[j][i]}}
  end

  def update_diagonals
    @diagonals = []
    update_diagonals_top_left_to_bottom_right
    update_diagonals_bottom_left_to_top_right
  end

  def update_diagonals_top_left_to_bottom_right
    #diagonals = []
    starting_cells = [[0,3],[0,2],[0,1],[0,0],[1,0],[2,0]]
    starting_cells.each do |cell|
      current_diagonals = []
      row = cell[0]
      col = cell[1]
      until row > 5 || col > 6
        current_diagonals << @contents[row][col]
        row += 1
        col += 1
      end
      @diagonals << current_diagonals
    end
  end

  def update_diagonals_bottom_left_to_top_right
    starting_cells = [[3,0],[4,0],[5,0],[5,1],[5,2],[5,3]]
    starting_cells.each do |cell|
      current_diagonals = []
      row = cell[0]
      col = cell[1]
      until row < 0 || col > 6
        current_diagonals << @contents[row][col]
        row -= 1
        col += 1
      end
      @diagonals << current_diagonals
    end
  end

end

 # @board = Board.new
 # @board.visualise
 # (0..5).each do |col|
 #   6.times {@board.place_move(col, "X")}
 # end
 # @board.visualise
 # puts @board.update_columns
 # puts @board.columns[6].length
# # 6.times {@board.place_move(5,"O")}
# @board.visualise
# @board.update_rows
# @board.update_columns
# @board.update_diagonals
# @board.update_lines_to_check
# puts @board.tie?
# #@board.columns.each {|col| puts @board.four_in_a_row?(col)}
# col = (0..5).map {|i| @board.contents[i][5]}
# col.each {|element| puts element.value}
# puts @board.four_in_a_row?(col)

# @board.columns.each {|a| a.each_with_index {|b,i| puts "#{b.value},#{i}"}}
# @board.columns[4].each {|a| puts a.value}
# puts @board.four_in_a_row?(@board.columns[4])
# #@board.columns.each {|col| puts @board.four_in_a_row?(col)}
# puts @board.win?
# 6.times {@board.place_move(4, "X")}
# @board.visualise
# puts @board.legal_move?(4)
# @board.place_move(3, "X")
# @board.visualise
# @board.place_move(3, "X")
# @board.visualise
# puts @board.contents[5][3].value
# puts @board.contents[4][3].value
# puts @board.contents[3][3].value
