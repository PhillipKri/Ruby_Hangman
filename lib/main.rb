# puts 'test'
class Hangman
  attr_reader :word
  attr_accessor :display
  def initialize
    @word = secret_word
    @display = []
    @counter = 0
    @word.length.times do
      @display << "_"
    end
  end


 
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

  def play
    until display.join == word
      char_guess = guess
      if @counter == 13
        puts 'You lose!'
        exit
      else
      @word.chars.each_with_index do |element, index|
        if element == char_guess
          display[index] = char_guess
        end
      end
      p display.join
      end
    end
    puts 'Congratulations!! You solved it'
    exit
  end

  def guess
    puts 'Choose a letter'
    letter = gets.chomp
    until /[a-z]/.match(letter)
      puts 'invalid character, try again'
      letter = gets.chomp
    end
    @counter += 1
    letter
  end
end


test = Hangman.new
p test.word
p test.play
