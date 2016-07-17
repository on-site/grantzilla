source "https://rubygems.org"

ruby "2.3.0"

gem "accountingjs-rails"
gem "better_errors"
gem "binding_of_caller"
gem "bootstrap-sass", "~> 3.3.6"
gem "bootstrap3-datetimepicker-rails", "~> 4.17.37"
gem "bootstrap-guardsjs-rails", "~> 0.4"
gem "cocoon"
gem "coffee-rails", "~> 4.2"
gem "devise", "~> 4.2"
gem "devise-bootstrap-views"
gem "jquery-rails"
gem "jquery-turbolinks"
gem "jbuilder", "~> 2.0"
gem "momentjs-rails", ">= 2.9.0"
gem "newrelic_rpm"
# paperclip with support for S3 storage with aws-sdk v2
# has not been published yet but is on master as of 1/22/16.
gem "paperclip", github: "thoughtbot/paperclip"
gem "pg"
gem "puma"
gem "rack-timeout"
gem "rails", "~> 5.0"
gem "react-rails"
gem "rmagick"
gem "sass-rails", "~> 5.0"
gem "sdoc", "~> 0.4.0", group: :doc
gem "select2-rails"
gem "simple_form"
gem "turbolinks"
gem "uglifier", ">= 1.3.0"
gem "wicked"
gem "wicked_pdf"
gem "will_paginate", "~> 3.1.0"
gem "will_paginate-bootstrap"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug"
  gem 'factory_girl_rails'
  gem "rspec-rails", "~> 3.5"
  gem "rubocop", "~> 0.36"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "letter_opener"
  gem "wkhtmltopdf-binary-edge"
end

group :production do
  gem "aws-sdk"
  gem "mailgun_rails"
  gem "sidekiq"
  gem "rails_12factor"
  gem "wkhtmltopdf-heroku"
end
