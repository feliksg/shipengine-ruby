# frozen_string_literal: true

# More info at https://github.com/guard/guard#readme
guard :minitest do
  watch(%r{^test/(.*)_test\.rb$})
  watch(%r{^lib/(.+)\.rb$})         { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^test/test_helper\.rb$}) { 'test' }
end
