class MovieIdeas::Movie
    attr_accessor :title, :release_date, :vote_average, :vote_count, :genre, :overview, :release_year, :id

    @@all = []
    @@selection = []

    def initialize(title)
        @title = title
        @@all << self
    end

    def self.all
        @@all
    end

    def self.pick_random_10
        @@selection = @@all.sample(10)
    end

    def self.selection
        @@selection
    end

end