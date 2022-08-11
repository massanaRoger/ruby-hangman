# frozen_string_literal: true

# Class to play and save the game
class Game
  attr_reader :word, :word_arr

  def initialize(contents)
    @contents = contents
    @word = getword
    @word_arr = Array.new(word.length, '_')
    @incorrect = 0
    @correct = 0
    @remaining_guesses = 11
  end

  def play_game
    while word_arr.filter { |word| word == '_' }.length.positive? && @remaining_guesses > 0
      puts 'Input a character'
      char = gets.chomp[0].downcase
      play_round(char)
      put_info(word_arr)
    end
    @remaining_guesses != 0
  end

  private

  def play_round(char)
    if word.include?(char)
      word.each_char.with_index { |c, index| word_arr[index] = char if c == char }
      @correct += 1
    else
      @incorrect += 1
      @remaining_guesses -= 1
    end
  end

  def put_info(word_arr)
    puts word_arr.join(' ')
    puts "Incorrect attempts: #{@incorrect}"
    puts "Correct attempts: #{@correct}"
    puts "Remaining guesses: #{@remaining_guesses}"
  end

  def getword
    @contents
      .map { |line| line.gsub("\n", '') }
      .filter { |line| line.length >= 5 && line.length <= 12 }
      .sample
  end
end

contents = File.readlines('google-10000-english-no-swears.txt')
game = Game.new(contents)
won = game.play_game
message = won ? 'You won!' : 'You lost!'
puts message
