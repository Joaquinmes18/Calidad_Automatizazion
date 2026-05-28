Given('I am on the Sauce Demo login page') do
  visit 'https://www.saucedemo.com/'
end

When('I enter {string} as username') do |username|
  fill_in 'user-name', with: username
end

When('I enter {string} as password') do |password|
  fill_in 'password', with: password
end

When('I click the {string} button on the login form') do |button_name|
  case button_name
  when 'Login'
    click_button 'login-button'
  else
    raise "Unsupported button: #{button_name}"
  end
end

Then('the login result should be {string}') do |expected_result|
  if expected_result == 'redirected to inventory page'
    expect(page).to have_current_path('/inventory.html', url: false)
    expect(page).to have_content('Products')
    expect(page).to have_css('.inventory_list')
    expect(page).to have_css('.shopping_cart_link')
  else
    expect(page).to have_css('[data-test="error"]', text: expected_result)
    expect(page).not_to have_current_path('/inventory.html', url: false)
    expect(page).to have_css('#user-name', visible: true)
  end
end
