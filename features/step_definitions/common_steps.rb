Given('I am logged in as {string} with password {string}') do |username, password|
  login_page.visit_page
  login_page.login(username, password)
  expect(inventory_page.on_page?).to be true
end

Given('I am on the inventory page') do
  expect(inventory_page.on_page?).to be true
end

Given('I am on the cart page') do
  cart_page.visit_page
  expect(cart_page.on_page?).to be true
end

Given('I have added the product {string} to the cart') do |product_name|
  inventory_page.add_product_to_cart(product_name)
end

Then('the cart badge should show {string}') do |count|
  expect(inventory_page.has_cart_badge?).to be true
  expect(inventory_page.cart_badge_text).to eq(count)
end

Then('the cart badge should not be visible') do
  expect(inventory_page.has_cart_badge?).to be false
end

Then('I should see {int} products in the inventory') do |count|
  expect(inventory_page.product_items.size).to eq(count)
end

Then('the {string} button should be visible for {string}') do |button_text, product_name|
  if button_text == 'Add to cart'
    expect(inventory_page.add_button_visible?(product_name)).to be true
  elsif button_text == 'Remove'
    expect(inventory_page.remove_button_visible?(product_name)).to be true
  else
    raise "Unknown button text: #{button_text}"
  end
end
