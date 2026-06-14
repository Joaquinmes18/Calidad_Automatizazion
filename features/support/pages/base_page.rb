require 'capybara/dsl'
require 'rspec/expectations'

class BasePage
  include Capybara::DSL
  include RSpec::Matchers
end
