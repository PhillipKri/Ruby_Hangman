require 'yaml'
require 'json'

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

  def save_game
    data = {
      :word => @word,
      :display => @display,
      :counter => @counter
    }
    file = File.open 'savefile.yml', 'w'
    file.puts YAML.dump(data)
    file.close
  end

  def save_to_json
    data = {
      :word => @word,
      :display => @display,
      :counter => @counter
    }
    f = File.open('json_save.json', 'w')
    File.write(f,JSON.dump(data))
    f.close
  end

  def load_from_json
    f = File.open('json_save.json')
    data = JSON.load(f)
    @word = data['word']
    @display = data['display']
    @counter = data['counter']
  end

  def load_game
    data = YAML.load(File.open('savefile.yml'))
    @word = data[:word]
    @display = data[:display]
    @counter = data[:counter]
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
    if File.exist? ('savefile.yml') or File.exist? ('json_save.json') 
      puts 'Will you reload a save file? (Y/N)'
      if gets.chomp.downcase == 'y'
        # load_game
        load_from_json
        display_res
      end
    end
    until display.join == word
      if @counter == 13
        puts "You lose! The actual word was: #{word}"
        if File.exist? ('json_save.json')
          # File.delete 'savefile.yml'
          File.delete 'json_save.json'
          exit
        else
        exit
        end
      else
      char_guess = guess
      word.chars.each_with_index do |element, index|
        if element == char_guess
          display[index] = char_guess
        end
      end
      # display_res
      end
    end
    display_res
    puts 'Congratulations!! You solved it'
    if File.exist? ('json_save.json')
      # File.delete 'savefile.yml'
      File.delete 'json_save.json'
      exit
    else
    exit
    end
  end

  def guess
    puts 'Choose a letter, or if you wish to save then type "1"'
    display_res
    letter = gets.chomp
    if letter == '1'
      # save_game
      save_to_json
      puts 'Game saved'
      puts 'Do you want to leave? (Y/N)'
      if gets.chomp.downcase == 'y'
        exit
      end
    end
    until /[a-z]/.match(letter)
      puts 'invalid character, try again'
      letter = gets.chomp
    end
    @counter += 1
    letter
  end

  
  
  def display_res
    puts display.join
  end
end


game = Hangman.new
game.play

