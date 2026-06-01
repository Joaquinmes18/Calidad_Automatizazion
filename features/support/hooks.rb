require 'fileutils'

Before do
  page.driver.browser.manage.window.maximize
end

Before('@login_required') do
  visit 'https://www.saucedemo.com/'
  fill_in 'user-name', with: 'standard_user'
  fill_in 'password', with: 'secret_sauce'
  click_button 'login-button'

  expect(page).to have_current_path('/inventory.html', url: false)
  expect(page).to have_css('.inventory_list')
end

Before('@checkout_ready') do
  visit 'https://www.saucedemo.com/'
  fill_in 'user-name', with: 'standard_user'
  fill_in 'password', with: 'secret_sauce'
  click_button 'login-button'

  expect(page).to have_current_path('/inventory.html', url: false)
  find('[data-test="add-to-cart-sauce-labs-backpack"]').click
  find('.shopping_cart_link').click

  expect(page).to have_current_path('/cart.html', url: false)
  expect(page).to have_css('.cart_item .inventory_item_name', text: 'Sauce Labs Backpack')
  find('[data-test="checkout"]').click

  expect(page).to have_current_path('/checkout-step-one.html', url: false)
end

After do |scenario|
  if scenario.failed?
    FileUtils.mkdir_p('screenshots')
    timestamp = Time.now.strftime('%Y%m%d_%H%M%S')
    name      = scenario.name.gsub(/[^A-Za-z0-9_]/, '_')[0..50]
    save_screenshot("screenshots/FAILED_#{name}_#{timestamp}.png")
  end

  Capybara.current_session.driver.quit
end
