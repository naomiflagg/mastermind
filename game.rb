# frozen_string_literal: true

class Game
  require 'pry'
  require_relative('human_player.rb')
  require_relative('computer_player.rb')
  require_relative('board.rb')

  attr_accessor :colors, :guess, :code

  def initialize
    @colors = %w[red orange yellow green blue purple]
    @game_board = Board.new
    @human = HumanPlayer.new(self)
    @computer = ComputerPlayer.new(self)
  end

  def begin_game
    display_instructions
    get_roles
    get_code
    play_turn
  end

  def display_instructions
    puts "Welcome to Mastermind! This a two-player game. One player,\n" \
    "the codemaker, makes a 4-color code. The other, the codebreaker,\n" \
    "has to figure out the code by guessing combinations. The codemaker\n" \
    "will tell the codebreaker how many colors in the guess sequence \n" \
    "are correct but not in the right place, and how many colors are\n" \
    "both correct and in the right place.\n" \
    'The color options: red orange yellow green blue purple'
  end

  def get_roles
    # Ask human for role choice, then assign variables based on selection
    @codemaker = @human.input_role == 'codemaker' ? @human : @computer
    @codebreaker = @codemaker == @human ? @computer : @human
  end

  def get_code
    puts "What is the secret code? Enter 4 colors. Example: 'red blue red green'."
    @code = @codemaker.input_code
  end

  def play_turn
    @guesses = 0
    loop do
      get_guess
      @game_board.add_guess(@guess)
      break if game_finished?

      get_feedback
      puts @feedback
      @game_board.add_feedback(@feedback)
      @game_board.display_game
    end
  end

  def get_guess
    puts "#{12 - @guesses} guesses left.\nGuess the code. Enter 4 colors. Example: 'red blue red green'."
    @guess = @codebreaker.input_guess
    @guesses += 1
  end

  def game_finished?
    if @guess == @code
      p 'The guess is correct! The codebreaker wins!'
    elsif @guesses == 12
      p "The last guess is not correct. The secret code\n"
      "is #{code}. The codemaker wins!"
    end
  end

  def get_feedback
    puts "Time for feedback! How many in the guess are correct color and correct placement (0-4)?\n" \
    'And how many in the guess are correct color but wrong placement (0-4)? Enter two numbers.'
    input = @codemaker.input_feedback
    @feedback = ["Correct color and placement: #{input[0]}", "Correct color, wrong placement: #{input[1]}"]
  end
end

new_game = Game.new
new_game.begin_game
