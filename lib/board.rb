require_relative 'cell'


class Board
  attr_reader :contents

  def initialize
    @contents = Array.new(6){Array.new(7) {Cell.new}}
  end

  def visualise
    divider = "+-----+-----+-----+-----+-----+-----+-----+"
    @contents.each do |row|
        print "\n"
        puts divider
          row.each do |cell|
              print "|  #{cell.value}   "
          end
          print "|"
     end
     print "\n"
     puts "#{divider}"
     print "   0     1     2     3     4     5     6\n\n"
  end

end
