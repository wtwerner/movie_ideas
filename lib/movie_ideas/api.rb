class MovieIdeas::API
    attr_accessor :url

    URL = "https://api.themoviedb.org/3"

    def initialize(url)
        @url = url
    end

    def get_response_body
        uri = URI.parse(@url)
        response = Net::HTTP.get_response(uri)
        response.body
    end

    def parse_json
        JSON.parse(self.get_response_body)
    end

    def self.get_genres
        @genre_hash = self.new("#{URL}/genre/movie/list?api_key=#{ENV["TMDB_KEY"]}&language=en-US").parse_json
        self.make_genres
    end

    def self.make_genres
        @genre_hash["genres"].each do |genre|
            name = genre["name"]
            id = genre["id"]
            Genre.new(name, id)
        end
    end

    def self.get_with_user_inputs(genre, min_score, min_year, max_year)
        if max_year == nil
            max_year = Time.now.year
        end
        if min_year == nil
            min_year = "1900"
        end
        month = Time.now.strftime("%m")
        day = Time.now.strftime("%d")
        current_page = 1
        while current_page <= 5
            url = "#{URL}/discover/movie?api_key=#{ENV["TMDB_KEY"]}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=#{current_page}&vote_count.gte=50&primary_release_date.gte=#{min_year}-#{month}-#{day}&primary_release_date.lte=#{max_year}-#{month}-#{day}&vote_average.gte=#{min_score}&with_genres=#{genre.id}"
            @movies_hash = self.new(url).parse_json
            self.make_movies
            current_page += 1
        end
    end

    def self.make_movies
        @movies_hash["results"].each do |movie|
            new_movie = MovieIdeas::Movie.new(movie["title"])
            new_movie.id = movie["id"]
            new_movie.release_date = movie["release_date"]
            new_movie.release_year = movie["release_date"][0..3]
            new_movie.vote_average = movie["vote_average"]
            new_movie.vote_count = movie["vote_count"]
            new_movie.overview = movie["overview"]
            new_movie.genre = @genre
        end
    end

end