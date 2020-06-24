require_relative 'lib/movie_ideas/version'

Gem::Specification.new do |spec|
  spec.name          = "movie_ideas"
  spec.version       = MovieIdeas::VERSION
  spec.authors       = ["Tommy Werner"]
  spec.email         = ["wtwerner@gmail.com"]

  spec.summary       = %q{Get movie recommendations on demand.}
  spec.description   = %q{A command line tool to suggest movies based on specified criteria.}
  spec.homepage      = "http://www.wtwernerplaceholder.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "http://www.wtwernerplaceholder.com"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://www.wtwernerplaceholder.com"
  spec.metadata["changelog_uri"] = "http://www.wtwernerplaceholder.com"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"

end
