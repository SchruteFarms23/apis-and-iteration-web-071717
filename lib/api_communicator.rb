require 'rest-client'
require 'json'
require 'pry'



# make the web request
def get_character_hash
    all_characters = RestClient.get('http://www.swapi.co/api/people/')
    character_hash = JSON.parse(all_characters)
end


# collect those film API urls, make a web request to each URL to get the info
#  for that film
def get_film_info(film_link_array)
    film_link_array.map do |film_link|
        #puts film_link
        film_info = RestClient.get(film_link)
        film_info_hash = JSON.parse(film_info)
    end
end



def get_character_movies_from_api(character)
    film_link_array = []
    
    get_character_hash["results"].each do |each_character|
        # iterate over the character hash to find the collection of `films` for the given
        #   `character`
        if each_character["name"].downcase.include?(character)
            film_link_array = each_character["films"]
            puts "\nYou searched for: #{each_character["name"]},\nwho appears in the following Star Wars Films:\n\n"
        end
    end
    
    if film_link_array == []
        puts "Sorry, we don't have information on that character."
        
    end
    
    get_film_info(film_link_array)
    # return array of film info
end

# this collection will be the argument given to `parse_character_movies`
#  and that method will do some nice presentation stuff: puts out a list
#  of movies by title. play around with puts out other info about a given film.


def parse_character_movies(films_hash)
    # some iteration magic and puts out the movies in a nice list
    print_film_array = []
    films_hash.each_with_index do |film, index|
        print_film_array << "Episode #{film["episode_id"]} #{film["title"]}"
    end
    puts print_film_array.sort
    puts "\n"
end

def show_character_movies(character)
    films_hash = get_character_movies_from_api(character)
    parse_character_movies(films_hash)
    # #if films_hash == []
    #   require "../bin/run.rb"
    # #end
end
