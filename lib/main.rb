# puts 'test'



 

 def secret_word
  contents = File.read('google-10000-english-no-swears.txt').split("\n")
  legal_words = Array.new
  contents.each do |e|
    if e.length > 4 && e.length < 13
      legal_words.push(e)
    end
  end
  legal_words.sample
end
puts secret_word


