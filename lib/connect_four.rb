require_relative 'announcer'
require_relative 'board'
require_relative 'player'

def start_game
  @announcer = Announcer.new
  @announcer.say_hello
  @board = Board.new
  @board.visualise
  @announcer.explain_rules
  1.upto(2) { |a| @announcer.ask_player_name(a) }
  @announcer.create_players
end

def new_turn
end



start_game
new_turn
