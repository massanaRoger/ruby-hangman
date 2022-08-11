# frozen_string_literal: true

# Class to play and save the game
class Game
  attr_reader :word, :word_arr

  def initialize(contents)
    @contents = contents
    @word = getword
    @word_arr = Array.new(word.length, '_')
  end

  def play_game
    while word_arr.filter { |word| word == '_' }.length.positive?
      puts 'Input a character'
      char = gets.chomp[0].downcase
      if word.include?(char)
        word.each_char.with_index { |c, index| word_arr[index] = char if c == char }
      end
      puts word_arr.join(' ')
    end
  end

  private

  def getword
    @contents
      .map { |line| line.gsub("\n", '') }
      .filter { |line| line.length >= 5 && line.length <= 12 }
      .sample
  end
end

contents = File.readlines('google-10000-english-no-swears.txt')
game = Game.new(contents)
game.play_game
