Given('I am logged in as {string} with password {string}') do |username, password|
  visit 'https://www.saucedemo.com/'
  fill_in 'user-name', with: username
  fill_in 'password', with: password
  click_button 'login-button'
  expect(page).to have_current_path('/inventory.html', url: false)
end

Given('I am on the inventory page') do
  expect(page).to have_current_path('/inventory.html', url: false)
  expect(page).to have_css('.inventory_list')
  expect(page).to have_css('.inventory_item', minimum: 1)
end

Given('I am on the cart page') do
  visit 'https://www.saucedemo.com/cart.html'
  expect(page).to have_current_path('/cart.html', url: false)
end

Given('I have added the product {string} to the cart') do |product_name|
  product_item = page.all('.inventory_item').find do |el|
    el.find('.inventory_item_name').text == product_name
  end
  product_item.find('.btn_inventory').click
end

Then('the cart badge should show {string}') do |count|
  expect(page).to have_css('.shopping_cart_badge', text: count)
end

Then('the cart badge should not be visible') do
  expect(page).not_to have_css('.shopping_cart_badge')
end

Then('I should see {int} products in the inventory') do |count|
  expect(page).to have_css('.inventory_item', count: count)
end

Then('the {string} button should be visible for {string}') do |button_text, product_name|
  product_item = page.all('.inventory_item').find do |el|
    el.find('.inventory_item_name').text == product_name
  end
  expect(product_item).to have_button(button_text)
end
