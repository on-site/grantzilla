source "https://rubygems.org"

ruby "2.3.0"

gem "better_errors"
gem "binding_of_caller"

# bundle exec rake doc:rails generates the API under doc/api.
gem "bootstrap-sass", "~> 3.3.6"
gem "bootstrap3-datetimepicker-rails", "~> 4.17.37"
gem "bootstrap-guardsjs-rails", "~> 0.4"
gem "coffee-rails", "~> 4.1.0"
gem "devise", "~> 3.5"
gem "devise-bootstrap-views"
gem "react-rails"

gem 'accountingjs-rails'
gem "jquery-rails"
gem "turbolinks"
gem "jquery-turbolinks"
gem "jbuilder", "~> 2.0"
gem "momentjs-rails", ">= 2.9.0"
gem "newrelic_rpm"
gem "pg"
gem "rails", "~> 4.2"
gem "sass-rails", "~> 5.0"
gem "sdoc", "~> 0.4.0", group: :doc
gem "select2-rails"
gem "uglifier", ">= 1.3.0"

gem "wicked"
gem "simple_form"
gem "cocoon"

# paperclip with support for S3 storage with aws-sdk v2
# has not been published yet but is on master as of 1/22/16.
gem "paperclip", github: "thoughtbot/paperclip"
gem "rmagick"
gem "puma"
gem "rack-timeout"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.4"
  gem "rubocop", "~> 0.36"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "letter_opener"
end

group :production do
  gem "aws-sdk"
  gem "mailgun_rails"
  gem "sidekiq"
  gem "rails_12factor"
end
