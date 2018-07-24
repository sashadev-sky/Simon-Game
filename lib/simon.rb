require 'colorize'

class Simon
  COLORS = %w(green red yellow blue)

  attr_reader :sequence_length, :game_over

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    system("clear")
    until @game_over
      take_turn
      system("clear")
    end

    game_over_message
    reset_game
    abort("please try again!")
  end

  def take_turn
    show_sequence
    require_sequence
    unless @game_over
      round_success_message
      @sequence_length += 1
    end
  end

  def show_sequence
    add_random_color
    @seq.each do |color|
      puts color.colorize(color.to_sym)
      sleep 0.75
      system("clear")
      sleep 0.25
    end
  end

  def require_sequence
    puts "Repeat the sequence by entering the first letter of each color on a new line."
    @seq.each do |color|
      user_color = gets.chomp
      if color[0] != user_color
        @game_over = true
        break
      end
    end
    sleep 0.25
  end

  def round_success_message
    puts "Correct. Next round"
  end

  def game_over_message
    puts "Sorry, incorrect sequence or you typed in your colors wrong. You made it #{sequence_length - 1} rounds!"
  end

  private

  attr_reader :seq

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def add_random_color
    @seq << COLORS.sample
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Simon.new
  game.play
end
