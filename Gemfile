source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Gems used for interfacing with the database

group :production do
  gem 'pg' # Use PostgresSQL in production
end
group :development, :test do
  gem 'sqlite3'
end

# Template engines

gem 'haml'

# Asset template engines

gem 'json'
gem 'sass'
gem 'coffee-script'
group :production do
  # gem 'therubyracer' #javascript executable
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use thin as the production web server
group :production do
  # gem 'thin'
end

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
end

# Miscellaneous
gem 'inherited_resources'
gem 'gravtastic'