source 'https://rubygems.org'

ruby '2.1.0'

gem 'rails'

gem 'annotate'
gem 'devise'
gem 'paperclip'
gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem 'twitter-bootstrap-rails', git: 'git://github.com/seyhunak/twitter-bootstrap-rails.git', branch: "bootstrap3"

gem 'bootstrap_form'
gem "rails_email_validator"
gem "cancan"
gem "haml-rails"
gem "aws-sdk"


group :production, :staging do
  gem 'rails_12factor'
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development do
  gem 'quiet_assets'
  gem 'letter_opener'
  gem "rails-erd"
  gem 'sqlite3'
  gem 'binding_of_caller'
  gem 'better_errors'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem "ransack", github: "activerecord-hackery/ransack", branch: "rails-4.1"

gem 'by_star'
gem 'will_paginate-bootstrap'

