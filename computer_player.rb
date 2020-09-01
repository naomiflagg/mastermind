class ComputerPlayer

  def initialize(game)
    @game = game
  end

  def input_code
    puts 'Computer has selected a secret code.'
    4.times.map { @game.colors.sample }
  end

  def input_guess
    puts 'Computer has made a guess.'
    p @game.colors.sample(4)
  end

  def input_feedback
    # Duplicate code and guess arrays for manipulation
    @temp_code = @game.code.dup
    @temp_guess = @game.guess.dup
    puts 'Computer has entered feedback.'
    [find_exact_match, find_color_match]
  end

  # Check for exact match with code. Delete if match to avoid additional color match.
  def find_exact_match
    exact = 0
    index = 0
    4.times.map do
      if @temp_code[index] == @temp_guess[index]
        exact += 1
        @temp_code.delete_at(index)
        @temp_guess.delete_at(index)
      else
        index += 1
      end
    end
    exact
  end

  def find_color_match
    color = 0
    @temp_guess.each do |element|
      # Check for color in sequence. Delete if match to avoid additional color match.
      if @temp_code.include?(element)
        color += 1
        @temp_code.delete_at(@temp_code.index(element))
      end
    end
    color
  end
end
