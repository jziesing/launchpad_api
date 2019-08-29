source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '5.2.3'
gem 'token_master', '~> 1.0'
gem 'sentry-raven', '~> 2.0'
gem 'rubocop'
gem 'rails_util', github: 'launchpadlab/rails_util'
gem 'rack-cors', '~> 1.0'
gem 'pg', '~> 0.18'
gem 'paper_trail', '~> 10.0'
gem 'lp_token_auth', '~> 0.3'
gem 'figaro', '~> 1.0'
gem 'decanter', '~> 1.0'
gem 'bcrypt', '~> 3.0'
gem 'active_model_serializers', '~> 0.10'

gem 'puma', '~> 3.11'






gem 'bootsnap', '>= 1.1.0', require: false


group :development, :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'pry-rails', '~> 0.3'
  gem 'faker', '~> 1.0'
  gem 'factory_bot_rails', '~> 5.0'

  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'bullet', '~> 6.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers', '~> 3.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
