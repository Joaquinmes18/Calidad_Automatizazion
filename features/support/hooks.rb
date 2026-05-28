require 'fileutils'

Before do
  page.driver.browser.manage.window.maximize
end

After do |scenario|
  FileUtils.mkdir_p('screenshots')
  timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
  name      = scenario.name.gsub(/[^A-Za-z0-9_]/, '_')[0..50]
  status    = scenario.failed? ? 'FAILED' : 'PASSED'
  save_screenshot("screenshots/#{status}_#{name}_#{timestamp}.png")
  Capybara.current_session.driver.quit
end
