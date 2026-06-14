require 'fileutils'

Before do
  page.driver.browser.manage.window.maximize
end

Before('@login_required') do
  login_page.visit_page
  login_page.login('standard_user', 'secret_sauce')
  expect(inventory_page.on_page?).to be true
end

After do |scenario|
  if scenario.failed?
    FileUtils.mkdir_p('screenshots')
    timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
    name      = scenario.name.gsub(/[^A-Za-z0-9_]/, '_')[0..50]
    save_screenshot("screenshots/FAILED_#{name}_#{timestamp}.png")
  end
end
