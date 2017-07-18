require 'rest-client'
require 'json'
require 'pry'

# def get_info_for_film(film_url)
  
# end

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  #puts character_hash["results"]

  # character_hash is an array of hashes (one hash per char)
  
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  film_link_array = []
  character_hash["results"].each do |each_character|
    if each_character["name"].downcase.include?(character)
      film_link_array = each_character["films"]
      puts "You searched for: #{each_character["name"]}"
    end
  end
  #nice


  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  film_link_array.map do |film_link|
    #puts film_link
    film_info = RestClient.get(film_link)
    film_info_hash = JSON.parse(film_info)
  end
   # film_link_array is array of film_info_hashes, one for each film character is in



  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film


  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end




def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each_with_index do |film, index|
    puts "#{index+1} #{film["title"]}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end





## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
