class Genre
    attr_accessor :name, :id

    @@all = []

    def initialize(name, id)
        @name = name
        @id = id
        @@all << self
    end

    def self.all
        @@all
    end
end