source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
# gem "jbuilder"

gem "bcrypt", "~> 3.1.7"
gem "dotenv-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "jwt"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "active_model_serializers", "~> 0.10.0"

gem "rack-cors"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "factory_bot_rails"

  gem "pry"
  gem "pry-rails"
  gem "letter_opener_web"
  gem "bullet"
  gem "simplecov"
end

group :test do
  gem "rspec-rails"
  gem "faker"
end
