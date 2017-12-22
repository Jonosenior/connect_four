require_relative 'announcer'
require_relative 'board'
require_relative 'player'

def start_game
  @announcer = Announcer.new
  @announcer.title
  @announcer.say_hello
  @board = Board.new
  @board.visualise
  @announcer.explain_rules
  1.upto(2) { |a| @announcer.ask_player_name(a) }
  @announcer.create_players
  @announcer.set_current_player
end

def new_turn
  loop do
    @board.visualise
    input = @announcer.elicit_move
    while !@board.legal_move?(input)
      @announcer.try_again
      input = @announcer.elicit_move
    end
    @board.place_move(input.to_i, @announcer.current_player.marker)
    analyse_turn
    @announcer.switch_current_player
  end
end

def analyse_turn
  # @board.update_rows
  # @board.update_columns
  # @board.update_diagonals
  # @board.update_lines_to_check
  game_over if @board.win? || @board.tie?
end

def game_over
  @board.visualise
  @board.win? ? @announcer.victory : @announcer.draw
  play_again?
end

def play_again?
  @announcer.play_again? ? start_game : @announcer.goodbye
end


start_game
new_turn
