require_relative 'player'


class Announcer
  attr_reader :player_names, :player1, :player2

  def initialize
    @player_names = []
  end

  def set_current_player
    @current_player = [@player1, @player2].sample
  end

  def switch_current_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def say_hello
    puts "\n\nWelcome to Connect Four, motherfuckers."
  end

  def explain_rules
    puts "This is the board. You choose a column, and the game places your marker at the top."
    puts "The winner is the first person to get four in a row."
    puts "To start, I need your names."
  end

  def ask_player_name(player_number)
    puts "What's your name, Player #{player_number}?"
    @player_names << gets.chomp
  end

  def create_players
    @player1 = Player.new(@player_names[0], "O")
    @player2 = Player.new(@player_names[1], "X")
  end

  def elicit_turn
    puts "OK, it's your move #{current_player}"
  end


end
