Given(/^I am on the Mercury Tours homepage$/) do
     page.driver.browser.manage.window.maximize
     visit('http://demo.guru99.com/test/newtours/')

end

Given(/^I click the "([^"]*)" link$/) do |linkText|
  click_link(linkText)
end

When(/^I enter the required fields as show below$/) do |table|
  data = table.rows_hash
  data.each_pair do |key, value|
    case key
	   when "First Name:"
    	fill_in 'firstName', :with => value
    	@name = value
	   when "Last Name:"
		  fill_in 'lastName', :with => value
		  @lastName = value
     when "Phone:"
		  fill_in 'phone', :with => value
     when "Email:"
		  fill_in 'userName', :with => value
	   when "Address:"
		  fill_in 'address1', :with => value
	   when "City:"
		  fill_in 'city', :with => value
	   when "State/Province:"
		  fill_in 'state', :with => value
	   when "Postal Code:"
		  fill_in 'postalCode', :with => value
	   when "Country:"
		  select(value, :from => 'country')
	   when "User Name:"
		  fill_in 'email', :with => value
		  @userName = value
	   when "Password:"
		  fill_in 'password', :with => value
	   when "Confirm Password:"
		  fill_in 'confirmPassword', :with => value
		  @password = value
	   end #case
  end #each
end

When(/^send my registration form$/) do
  #close ad popup 
  sleep 3
  #press button - close ad
  find(:css, 'div[role="button"][class*="dismiss"]').click rescue nil
  # click submit button using xpath relative
  find(:xpath, "//input[@name='submit']").click
end

Then(/^the confirmation screen is show$/) do
  greeting = "Dear"+" "+@name+" "+@lastName 	
  expect(page).to have_content(greeting)
end

Then(/^my user name is "([^"]*)"$/) do |userName|
  labelText= "Note: Your user name is "+userName+"."
  puts "only for TEST "+labelText
  expect(page).to have_content(labelText)
  # Use xpath relative selector instead of absolute path
  userNameLabel = find(:xpath, "//font/b[contains(text(), 'mngr')]").text rescue find(:xpath, "//p[contains(text(), 'Note: Your user name is')]").text
  if labelText.include?(userName)
    puts "Validation for user name: Passed"    
  else
    raise "Validation for user name: Failed"    
    puts "Expected: "+labelText
    puts "Actual: "+userNameLabel
  end
end

#I enter my user and password
Given(/^I enter my user and password$/) do
  fill_in 'userName', :with => ENV['USER']
  fill_in 'password', :with => ENV['PSW']
end

#When I press the Submit button
When(/^I press the "([^"]*)" button$/) do |buttonText|
  find(:xpath, "//input[@type='submit'][@value='#{buttonText}']").click
end

#Then the login successfully message is displayed
Then(/^the login successfully message is displayed$/) do
    expect(page).to have_content("Login Successfully")
    puts "ONLY FOR TEST  PURPOSES"
    # Use relative xpath instead of absolute path
    header_text = find(:xpath, "//h3[contains(text(), 'Login Successfully')]").text rescue find(:css, 'h3').text
    puts header_text
end

#When I press the Submit button
When(/^I press the Submit button$/) do
  # Use relative xpath to find submit input
  find(:xpath, "//input[@type='submit']").click
end
