#Given I am on the sample homepage
Given(/^I am on the sample homepage$/) do
  visit 'http://demo.guru99.com/'
end

#When I enter blank details for Register
When(/^I enter blank details for Register$/) do
	fill_in 'emailid', :with => ""
end

#And Press the "Submit" button
When('Press the {string} button') do |buttonName|
  click_button(buttonName) 
end

#Then error "Email ID must not be blank" is show
Then(/^error "([^"]*)" is show$/) do |errorMessage|
  page.has_content?(errorMessage)
  sleep 2
end

#When I enter "carlos@test.com" for Register
When(/^I enter "([^"]*)" for Register$/) do |userName|
  fill_in 'emailid', :with => userName
end

#Then I should see the following table:
Then(/^I should see the following table:$/) do |table|
  loginMessage = 'Access details to demo site'
  # Use relative xpath instead of absolute
  expect(page).to have_xpath("//h2[contains(text(), '#{loginMessage}')]")
  data = table.rows_hash
  # Find table and verify each row
  table_element = find(:xpath, "//table")
  data.each_pair do |key, value|
    expect(table_element).to have_content(key)
    expect(table_element).to have_content(value)
  end
end

Then(/^I should see mngr(\d+) id$/) do |managerID|
  # Use relative xpath to find manager ID
  expect(page).to have_xpath("//td[contains(text(), 'mngr#{managerID}')]")
end
    