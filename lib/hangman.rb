
contents = File.readlines('google-10000-english-no-swears.txt')
def getword(contents)
  contents
    .map {|line| line.gsub("\n", '')}
    .filter {|line| line.length >=5 && line.length <= 12}
    .sample
end
word = getword(contents)
word_arr = Array.new(word.length, '_')
puts word

while word_arr.filter{|word| word == '_'}.length > 0
  puts "Input a character"
  char = gets.chomp[0]
  if word.include?(char)
    word.each_char.with_index{|c, index| word_arr[index] = char if c == char}
  end
  puts word_arr.join(' ')
end

