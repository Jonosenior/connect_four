require_relative 'cell'


class Board
  attr_reader :contents, :rows, :columns, :diagonals, :lines_to_check

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

  def legal_move?(column)
    column = Integer column #rescue false
    return false if !column_exists?(column)
    return false if !contains_empty_cell?(column)
    true
  end

  def contains_empty_cell?(column)
    column_contents = (0..5).map {|row| @contents[row][column]}
    return false if column_contents.none? {|cell| cell.value == " "}
    true
  end

  def column_exists?(column)
    return false if !(0..6).include?(column)
    true
  end

  def convert_to_integer(input)
    Integer input
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
    lines_to_check.each { |line| return true if four_in_a_row?(line) }
    false
  end

  def tie?
    lines_to_check.each { |line| return false if line.any? {|cell| cell.value == ' '} }
    true
  end

  def lines_to_check
    rows + columns + diagonals
  end

  def rows
    rows = contents
  end

  def columns
    columns = (0..6).map {|i|(0..5).map {|j| contents[j][i]}}
  end

  def diagonals
    diagonals_top_left_to_bottom_right + diagonals_bottom_left_to_top_right
  end

  def diagonals_top_left_to_bottom_right
    diagonals = []
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
      diagonals << current_diagonals
    end
    diagonals
  end

  def diagonals_bottom_left_to_top_right
    diagonals = []
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
      diagonals << current_diagonals
    end
    diagonals
  end

end
