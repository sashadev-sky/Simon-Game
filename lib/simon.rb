require 'colorize'

class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until @game_over
      take_turn
    end
    if @game_over
      game_over_message
      reset_game
      abort("please try again!")
    end
  end

  def take_turn
    show_sequence
    answer = require_sequence
    if answer == @seq
      round_success_message
      @sequence_length += 1
    else
      @game_over = true
    end
  end
  
  def show_sequence
    system("clear")
    result = add_random_color
    result.each { |color| puts color.colorize(color.to_sym) }
    sleep(2)
    system("clear")
  end

  def require_sequence
    puts "please enter the color sequence (ex. color, color)"
    answer = gets.chomp.downcase
    answer_arr = answer.split(", ")
    answer_arr
  end

  def add_random_color
    random_color = COLORS.sample
    @seq << random_color
    @seq
  end

  def round_success_message
    puts "Correct. Next round"
  end

  def game_over_message
    puts "Sorry, incorrect sequence. You made it #{sequence_length} rounds!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Simon.new
  game.play
end
