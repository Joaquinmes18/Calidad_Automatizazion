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

# ============================================================
# CONFIGURACIÓN DE NAVEGADOR - CAMBIA AQUÍ SEGÚN NECESITES
# ============================================================
# Opciones disponibles:
#   BROWSER_TYPE = :chrome    → Usa Google Chrome
#   BROWSER_TYPE = :brave     → Usa Brave Browser
BROWSER_TYPE = :brave
# ============================================================

class CapybaraDriverRegistrar
  # register a Selenium driver for the given browser to run on the localhost
  def self.register_selenium_driver(browser_type)
    Capybara.register_driver :selenium do |app|
      
      if browser_type == :brave
        options = Selenium::WebDriver::Chrome::Options.new
        
        # Intentar encontrar Brave en ubicaciones comunes
        brave_paths = [
          "C:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe",
          "C:/Program Files (x86)/BraveSoftware/Brave-Browser/Application/brave.exe"
        ]
        
        brave_found = nil
        brave_paths.each do |path|
          if File.exist?(path)
            brave_found = path
            break
          end
        end
        
        if brave_found
          options.binary = brave_found
          puts "✓ Brave encontrado en: #{brave_found}"
        else
          puts "✗ Brave no encontrado. Instalaciones probables:"
          puts "  - C:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe"
          puts "  - C:/Program Files (x86)/BraveSoftware/Brave-Browser/Application/brave.exe"
          puts "Usando Chrome como alternativa..."
          browser_type = :chrome
        end
        
        Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
      else
        # Chrome por defecto
        options = Selenium::WebDriver::Chrome::Options.new
        Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
      end
      
    end
  end
end

# Registrar el driver
CapybaraDriverRegistrar.register_selenium_driver(BROWSER_TYPE)

Capybara.run_server = false