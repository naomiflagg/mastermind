class HumanPlayer

  def initialize(game)
    @game = game
  end

  def input_role
    puts "Which role would you like? Type 'codemaker' or 'codebreaker'."
    loop do
      role = gets.chomp
      return role if %w[codemaker codebreaker].include?(role)

      puts 'Your input is not valid. Please select codemaker or codebreaker.'
    end
  end

  def input_code
    loop do
      code = gets.chomp.split(' ')
      return code if valid_input?(code, @game.colors, 4)
    end
  end

  def input_guess
    loop do
      guess = gets.chomp.split(' ')
      return guess if valid_input?(guess, @game.colors, 4)
    end
  end

  def input_feedback
    puts "Your code: #{@game.code}"
    loop do
      feedback = gets.chomp.split(' ')
      return feedback if valid_input?(feedback, %w[0 1 2 3 4], 2)
    end
  end

  def valid_input?(input, options, length)
    input.each do |element|
      unless options.include?(element) && input.size == length
        puts 'Your input is not valid. Try again.'
        break
      end
    end
  end
end
