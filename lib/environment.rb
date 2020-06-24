require_relative "./movie_ideas/version"
require_relative "./movie_ideas/cli"
require_relative "./movie_ideas/movie"
require_relative "./movie_ideas/api"
require_relative "./movie_ideas/genre"
require_relative ".env"
require 'pry'
require 'net/http'
require 'open-uri'
require 'json'


module MovieIdeas
  class Error < StandardError; end
  # Your code goes here...
end
