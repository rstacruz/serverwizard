source "http://rubygems.org"

gem "rake"

# Sinatra microframework
gem "sinatra", "~> 1.2.6", require: "sinatra/base"

# JS Compression
gem "jsmin", "~> 1.0.1"

# Template engines
gem "haml", "~> 3.1.1"
gem "sass", "~> 3.1.1"

# Sinatra extensions
gem "sinatra-content-for", require: "sinatra/content_for"
gem "sinatra-support", "~> 1.2.1", require: "sinatra/support"

# CSS extensions
gem "compass", "~> 0.11.1"

# Automatic development-time reloading of code
gem "pistol", "~> 0.0.2"

# Rtopia markup
gem "rtopia", "~> 0.2.3"

# Markdown (you may want to remove these later)
gem "maruku"

gem "hashie", "~> 1.0.0"
gem "RedCloth", "~> 4.2.7"

# # CoffeeScript support (with Heroku support)
gem "coffee-script", require: "coffee_script"
gem "therubyracer-heroku", "0.8.1.pre3", require: false

group :test do
  # Contexts for test/unit
  gem "contest"

  # Acceptance tests via browser simulation
  gem "capybara"

  # Forking tests
  gem "spork", "~> 0.8.4"
  gem "spork-testunit", "~> 0.0.5"

  # # RSpec-like syntax (two.should == 2)
  gem "renvy", "~> 0.2.2"

  # # Generates fake data (names, addresses, etc)
  # gem "ffaker", "~> 1.4.0"
end
