class MovieIdeas::CLI

    def call
        puts "\nWelcome to Movie Ideas!\n"
        binding.pry
        get_genres
        list_genres
        get_user_genre
        get_user_score
        list_eras
        get_user_era
        confirm_inputs
        search_api
        pick_random_10
        get_user_movie_selection
    end

    def get_genres
        MovieIdeas::API.get_genres
        MovieIdeas::API.make_genres
    end

    def list_genres
        puts "\nWhat genre do you want?\n"
        Genre.all.each.with_index(1) {|genre, index| puts "#{index}. #{genre.name}"}
    end

    def get_user_genre
        user_genre = gets.strip
        if user_genre.to_i.between?(1, Genre.all.count)
            @genre = Genre.all[user_genre.to_i-1]
        else
            puts "\nPlease select a number between 1 and #{Genre.all.count}\n"
            get_user_genre
        end 
    end

    def get_user_score
        puts "\nWhat should the minimum score be? (1-10)\n"
        user_score = gets.strip
        if user_score.to_i.between?(1, 10)
            @min_score = user_score
        else
            puts "\nPlease select a number between 1 and 10\n"
            get_user_score
        end 
    end

    def list_eras
        puts "\nHow old do you want the movie to be?\n"
        @eras = ["0-10 years", "10-20 years", "20-30 years", "30-40 years", "40-50 years", "50+ years", "I don't care"]
        @eras.each.with_index(1) {|era, index| puts "#{index}. #{era}"}
    end

    def get_user_era
        user_era = gets.strip
        if user_era.to_i.between?(1, @eras.count)
            @era = @eras[user_era.to_i-1]
            get_min_max_year(user_era)
        else
            puts "\nPlease select a number between 1 and #{@eras.count}\n"
            get_user_era
        end 
    end

    def display_inputs
        puts "Genre: #{@genre.name}"
        puts "Minimum score: #{@min_score}"
        puts "Age: #{@era}"
    end

    def confirm_inputs
        puts "\nAre these values correct? (y/n)\n"
        display_inputs
        user_input = gets.strip
        if user_input == "y"
            search_api
        elsif user_input == "n"
            self.call
        else
            puts "\nPlease enter y or n\n"
            confirm_inputs
        end
    end

    def input
        @input
    end

    def get_min_max_year(user_era)
        current_year = Time.now.year
        if user_era == "1"
            @min_year = current_year-10
            @max_year = nil
        elsif user_era == "2"
            @min_year = current_year-20
            @max_year = current_year-10
        elsif user_era == "3"
            @min_year = current_year-30
            @max_year = current_year-20
        elsif user_era == "4"
            @min_year = current_year-40
            @max_year = current_year-30
        elsif user_era == "5"
            @min_year = current_year-50
            @max_year = current_year-40
        elsif user_era == "6"
            @min_year = nil
            @max_year = current_year-50
        else
            @min_year = nil
            @max_year = nil
        end
    end

    def search_api
        MovieIdeas::API.get_with_user_inputs(@genre, @min_score, @min_year, @max_year)
        MovieIdeas::API.make_movies
    end

    def pick_random_10
        MovieIdeas::Movie.pick_random_10
    end

    def return_random_movies
        MovieIdeas::Movie.selection.each.with_index(1) {|movie, index| puts "#{index}. #{movie.title} (#{movie.release_year})"}
    end

    def get_user_movie_selection
        puts "\nWhich movie do you want to learn more about?\n"
        return_random_movies
        selection = gets.strip
        if selection.to_i.between?(1,10)
            show_movie_details(selection)
        else
            puts "Please select a number 1-10"
            get_user_movie_selection
        end
    end

    def show_movie_details(selection)
        movie = MovieIdeas::Movie.selection[selection.to_i - 1]
        puts "\n\n#{movie.title} (#{movie.release_year})"
        puts "\nAudience Score:\n"
        puts "#{movie.vote_average.to_i * 10}% (#{movie.vote_count} votes)"
        puts "\nSynopsis:\n"
        puts "#{movie.overview.scan(/(.{1,60})(?:\s|$)/m).join("\n")}"
        puts "\nMore Information: https://www.themoviedb.org/movie/#{movie.id}"
        puts "\nTMDb ID: #{movie.id}"
        puts "\nDo you want to choose a different movie? (y/n)\n"
        ask_if_done
    end

    def ask_if_done
        input = gets.strip
        if input == "y"
            get_user_movie_selection
        elsif input == "n"
            ask_for_new_search
        else
            puts "Please select y or n"
            ask_if_done
        end
    end

    def ask_for_new_search
        puts "\nDo you want to run a new search? (y/n)\n"
        input = gets.strip
            if input == "n"
                puts "\nThanks for using MovieIdeas! Have a good day!\n"
            elsif input == "y"
                self.call
            else
                puts "Please select y or n"
                ask_for_new_search
        end
    end

end

# :title, :release_date, :vote_average, :vote_count, :genre, :overview, :release_year