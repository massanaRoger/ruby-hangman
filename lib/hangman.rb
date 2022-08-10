
contents = File.readlines('google-10000-english-no-swears.txt')
def getword(contents)
  contents
    .map {|line| line.gsub("\n", '')}
    .filter {|line| line.length >=5 && line.length <= 12}
    .sample
end
word = getword(contents)
word_arr = Array.new(word.length, '_')

puts word_arr.join(' ')
puts word
