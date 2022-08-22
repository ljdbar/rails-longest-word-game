require 'open-uri'

class GamesController < ApplicationController
  def new
    a_2_z = [('a'..'z')].map(&:to_a).flatten
    @letters = (0...10).map { a_2_z[rand(a_2_z.length)] }.join
    # @letters = []
    # 10.times do
    #   @letters << [*'a'..'z'].sample
    # end
  end

  def score
    # if params[:play].exclude?(@letters)
    #   puts "sorry cannot be built"
    # end

    # @attempt = params[:attempt]
    # @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    # @dictionary = JSON.parse(URI.open(url).read)
    # if @dictionary['found'] == false
    #   @response = "Sorry but #{@attempt} is not a valid english word..."
    # else
    #   @response = "Congratulations! #{@attempt} is a valid word"
    # end

    word = params[:word]
    letters = JSON.parse(params[:letters])
    guess_letters = word.chars
    @count = guess_letters.all? { |letter| word.count(letter) <= letters.count(letter) }
    if @count
      valid_word_check = URI.open(url).read
      is_valid = JSON.parse(valid_word_check)["found"]
      if is_valid
        @result = 'Congratulations, you guesed a valid word'
      else
        @result = 'Sorry not an english word'
      end
    else
      @result = "Sorry you can't build #{word} with these letters"
    end
  end
end
