When('I open the hamburger menu') do
  find('#react-burger-menu-btn').click
  expect(page).to have_css('.bm-menu-wrap', visible: true)
end

When('I click {string} from the menu') do |option|
  case option
  when 'Reset App State'
    find('#reset_sidebar_link').click
  when 'Logout'
    find('#logout_sidebar_link').click
  else
    raise "Unsupported menu option: #{option}"
  end
end

When('I close the hamburger menu') do
  find('#react-burger-cross-btn').click
end

Then('I should be on the Sauce Demo login page') do
  expect(page).to have_current_path('/', url: false)
  expect(page).to have_css('#user-name', visible: true)
  expect(page).to have_css('#login-button', visible: true)
end

Then('the username field should be visible') do
  expect(page).to have_css('#user-name', visible: true)
end

Then('the login button should be visible') do
  expect(page).to have_css('#login-button', visible: true)
end
