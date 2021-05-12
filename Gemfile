# frozen_string_literal: true

source 'https://rubygems.org'

group :development do
  gem 'debase', require: false
  gem 'guard'
  gem 'guard-minitest'
  gem 'ruby-debug-ide', require: false
  gem 'solargraph', require: false
end

group :test do
  gem 'minitest'
  gem 'minitest-hooks'
  gem 'minitest-reporters'
  gem 'simplecov', require: false
  gem 'webmock'
end

group :test, :development do
  gem 'pry'
  gem 'rake'
  gem 'reek', require: false
  gem 'rubocop'
end

gemspec
