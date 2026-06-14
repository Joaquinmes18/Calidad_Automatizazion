When('I open the hamburger menu') do
  menu_component.open
end

When('I click {string} from the menu') do |option|
  case option
  when 'Reset App State'
    menu_component.reset_app_state
  when 'Logout'
    menu_component.logout
  else
    raise "Unsupported menu option: #{option}"
  end
end

When('I close the hamburger menu') do
  menu_component.close
end

Then('I should be on the Sauce Demo login page') do
  expect(login_page.username_field_visible?).to be true
  expect(login_page.login_button_visible?).to be true
end

Then('the username field should be visible') do
  expect(login_page.username_field_visible?).to be true
end

Then('the login button should be visible') do
  expect(login_page.login_button_visible?).to be true
end
