
contents = File.readlines('google-10000-english-no-swears.txt')
word = contents
  .map {|line| line.gsub("\n", '')}
  .filter {|line| line.length >=5 && line.length <= 12}
  .sample
puts word
