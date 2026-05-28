begin require 'rspec/expectations'; rescue LoadError; require 'spec/expectations'; end
require 'capybara'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'selenium-webdriver'
# PTravel Settings
ENV['USER']="Pepazo"
ENV['PSW']="ILoveQA"

# Set the host the Capybara tests should be run against
Capybara.app_host = "https://cba.ucb.edu.bo/"

# Set the time (in seconds) Capybara should wait for elements to appear on the page
Capybara.default_max_wait_time = 15
Capybara.default_driver = :selenium

class CapybaraDriverRegistrar
  # register a Selenium driver for the given browser to run on the localhost
  def self.register_selenium_driver(browser)
    Capybara.register_driver :selenium do |app|
      
      # Si el proyecto pide :chrome, interceptamos la llamada y abrimos Brave
      if browser == :chrome
        options = Selenium::WebDriver::Chrome::Options.new
        # RUTA DE BRAVE: Verifica que esta sea la correcta en tu PC
        options.binary = "C:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe"
        
        Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
      else
        Capybara::Selenium::Driver.new(app, :browser => browser)
      end
      
    end
  end
end

# Register various Selenium drivers
#CapybaraDriverRegistrar.register_selenium_driver(:internet_explorer)
#CapybaraDriverRegistrar.register_selenium_driver(:firefox)

# Al llamar a :chrome, el código de arriba redirigirá a Brave
CapybaraDriverRegistrar.register_selenium_driver(:chrome) 

Capybara.run_server = false