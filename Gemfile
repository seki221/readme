source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
# gem "rails", "~> 7.0.8", ">= 7.0.8.4"
gem 'rails', '~> 6.1.4'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use mysql as the database for Active Record
gem "mysql2", "~> 0.5"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

gem 'bootsnap', '>= 1.4.4', require: false
# gem 'bootstrap-modal-rails'
# gem 'sidekiq'  
# gem 'mini_magick'
gem 'simple_form'
gem 'country_select'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem 'carrierwave', '~> 3.0'

# Use Sass to process CSS
gem "sassc-rails"
# gem "dartsass-rails", "~> 0.4.0"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
gem 'kaminari'
gem 'bootstrap5-kaminari-views'
gem 'ransack'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'factory_bot_rails'
  gem 'minitest', '~> 5.25'
  gem 'rdoc', '~> 6.8'
  
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem 'listen', '~> 3.3'
  gem 'letter_opener_web'

  gem 'fullcalendar-rails'

  gem "faker"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  # gem "selenium-webdriver"
  
end

gem 'pg', group: :production
gem 'devise', group: [:development, :test, :production]

gem "webpacker", "~> 5.4"
