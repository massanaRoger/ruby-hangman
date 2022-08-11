# frozen_string_literal: true

require 'json'

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
      puts 'Do you want to play or save the game? (1) save, else play'
      option = gets.chomp.to_i
      if option == 1
        json_string = to_json
        file = File.open('test.json', 'w')
        file.write(json_string)
        puts json_string
        return
      end
      puts 'Input a character'
      char = gets.chomp[0].downcase
      play_round(char)
      put_info(word_arr)
    end
    @remaining_guesses != 0
  end


  def self.from_json string
    data = JSON.load File.read(string)
    p data 
    self.new(data['word'], data['word_arr'], data['incorrect'], data['correct'], data['remaining_guesses'])
  end

  def initialize(word, word_arr, incorrect, correct, remaining_guesses)
    @word = word
    @word_arr = word_arr
    @incorrect = incorrect
    @correct = correct
    @remaining_guesses = remaining_guesses
  end
  
  private

  def to_json
    {'word' => @word, 'word_arr' => @word_arr, 'incorrect' => @incorrect, 'correct' => @correct, 'remaining_guesses' => @remaining_guesses}.to_json
  end

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

puts 'Press 1 to load the game'
contents = File.readlines('google-10000-english-no-swears.txt')
game = gets.chomp.to_i == 1 ? Game.from_json('test.json') : Game.new(contents)
won = game.play_game
message = won ? 'You won!' : 'You lost!'
puts message
