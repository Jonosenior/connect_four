require_relative 'player'
require 'colorize'


class Announcer
  attr_reader :player_names, :player1, :player2, :current_player

  def initialize
    @player_names = []
  end

  def try_again
    puts "Make a proper move! (numbers 0-6)"
  end

  def elicit_move
    puts "\n\nWhat's your move, #{@current_player.name}?"
    gets.chomp
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
    puts "This is the board. Type a number to choose which column to place your marker in."
    puts "The winner is the first person to get four in a row.\n\n"
    puts "To start, I need your names."
  end

  def ask_player_name(player_number)
    puts "What's your name, Player #{player_number}?"
    @player_names << gets.chomp
  end

  def create_players
    @player1 = Player.new(@player_names[0], "X")
    @player2 = Player.new(@player_names[1], "O")
  end

  def victory
    puts "Well done! You won #{current_player.name}!"
  end

  def play_again?
    puts "Do you want to play again? (y/n)"
    answer = gets.chomp.downcase
    answer == "y" ? true : false
  end

  def goodbye
    puts "See you next time!"
    exit
  end

  def title
    puts "

     _______  _______  __    _  __    _  _______  _______  _______        _   ___
    |       ||       ||  |  | ||  |  | ||       ||       ||       |      | | |   |
    |       ||   _   ||   |_| ||   |_| ||    ___||       ||_     _|      | |_|   |
    |       ||  | |  ||       ||       ||   |___ |       |  |   |        |       |
    |      _||  |_|  ||  _    ||  _    ||    ___||      _|  |   |        |___    |
    |     |_ |       || | |   || | |   ||   |___ |     |_   |   |            |   |
    |_______||_______||_|  |__||_|  |__||_______||_______|  |___|            |___|"

  end


end
