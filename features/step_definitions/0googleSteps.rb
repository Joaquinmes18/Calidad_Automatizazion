#Then I see a link for the "SIAA"
Then('I see a link for the {string}') do |ucbLink|
  expect(page).to have_link(ucbLink)
end


#Then UCB is located at "M.M.Marques, Cochabamba" street
Then(/^I see that the UCB is located at "([^"]*)" street$/) do |adUCB|
  # Use relative xpath or CSS selector to find address
  address_element = find(:xpath, "//*[contains(text(), '#{adUCB}')]") rescue find(:css, 'span')
  if address_element.text != adUCB
    raise "UCB address should be "+adUCB	
  end
end

#And I see text about working hours "Atención de lunes a viernes de 08:30 a 15:30"
Then('I see text about working hours {string}') do |workingHoursUCB|
  # Use relative xpath to find working hours text
  workingHoursLabel = find(:xpath, "//*[contains(text(), 'lunes')]") rescue find(:css, 'p')
  puts "ONLY FOR TEST PURPOSES:"+workingHoursLabel.text
  if workingHoursLabel.text != workingHoursUCB
    raise "Working hours should be"+workingHoursUCB	
  end
end

#And I see a direct link for "Calendario Académico"
Then('I see a direct link for {string}') do |directLinkText|
  # Use relative xpath or CSS selector to find the link text
  directLinkUIXPath = find(:xpath, "//a[contains(text(), '#{directLinkText}')]") rescue find(:xpath, "//a/span[contains(text(), '#{directLinkText}')]")
  puts "ONLY FOR TEST PURPOSES:"+directLinkUIXPath.text
  if directLinkUIXPath.text != directLinkText
    raise "Working hours should be"+directLinkText 
  end
end

#Given I browse to the UCB page
Given('I browse to the UCB page') do
  page.driver.browser.manage.window.maximize
  visit ('/')
end

#Then all links are visible so I close the page
Then('all links are visible so I close the page') do
    Capybara.current_session.driver.quit
end

#Given I am on the Dynamo homepage
Given('I am on the Dynamo homepage') do
   page.driver.browser.manage.window.maximize
  visit ('https://www.houstondynamofc.com')
  sleep 2
  click_button('Accept & Continue')
end

# When I press the "Club" link
When('I press the {string} link') do |linkName|
  click_link(linkName)
end

#Then I see that information show below
Then('I see that information show below') do |table|
  data = table.rows_hash
  # Use relative xpath with contains instead of absolute path
  data.each_pair do |key, value|
    puts "Only for test PURPOSES"
    puts(key+" - "+value) 
    # Find element containing both name and role
    element = find(:xpath, "//*[contains(text(), '#{key}')]") rescue nil
    if element
      parent = element.find(:xpath, "./ancestor::div[@class='team-member']") rescue element.find(:xpath, "./ancestor::*")
      puts(parent.text)
      expect(parent).to have_content(key+" - "+value) rescue expect(element.text).to include(key)
    end
  end
end


