Given('I am on the Sauce Demo login page') do
  login_page.visit_page
end

When('I enter {string} as username') do |username|
  login_page.enter_username(username)
end

When('I enter {string} as password') do |password|
  login_page.enter_password(password)
end

When('I click the {string} button on the login form') do |button_name|
  case button_name
  when 'Login'
    login_page.click_login
  else
    raise "Unsupported button: #{button_name}"
  end
end

Then('the login result should be {string}') do |expected_result|
  if expected_result == 'redirected to inventory page'
    expect(inventory_page.on_page?).to be true
  else
    expect(login_page.has_error_message?(expected_result)).to be true
    expect(inventory_page.on_page?).to be false
    expect(login_page.username_field_visible?).to be true
  end
end
