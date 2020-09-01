class Board

  def initialize
    @board = []
    @feedback = []
  end

  def add_guess(guess)
    @board.push(guess)
  end

  def add_feedback(feedback)
    @feedback.push(feedback)
  end

  def display_game
    puts "Guesses: #{@board}\nFeedback: #{@feedback}."
  end
end
