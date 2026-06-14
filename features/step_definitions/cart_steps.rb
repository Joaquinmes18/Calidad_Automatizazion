When('I add the product {string} to the cart') do |product_name|
  inventory_page.add_product_to_cart(product_name)
end

When('I add the following products to the cart:') do |table|
  table.hashes.each do |row|
    inventory_page.add_product_to_cart(row['product_name'])
  end
end

Given('I have added the following products to the cart:') do |table|
  table.hashes.each do |row|
    inventory_page.add_product_to_cart(row['product_name'])
  end
end

Then('the cart should contain the product {string}') do |product_name|
  inventory_page.click_cart
  expect(cart_page.on_page?).to be true
  expect(cart_page.get_cart_product_names).to include(product_name)
end

Then('the cart should contain the following products:') do |table|
  inventory_page.click_cart
  expect(cart_page.on_page?).to be true
  expected = table.hashes.map { |row| row['product_name'] }
  expect(cart_page.get_cart_product_names).to include(*expected)
end

When('I go to the cart page') do
  inventory_page.click_cart
  expect(cart_page.on_page?).to be true
end

When('I remove {string} from the cart') do |product_name|
  cart_page.remove_product(product_name)
end

When('I remove the product {string} from the inventory') do |product_name|
  inventory_page.remove_product_from_inventory(product_name)
end

Then('the cart should be empty') do
  expect(cart_page.empty?).to be true
end

Then('the cart should contain only the following products:') do |table|
  expected_products = table.hashes.map { |row| row['product_name'] }
  expect(cart_page.get_cart_product_names).to match_array(expected_products)
end

Then('the cart should not contain the product {string}') do |product_name|
  expect(cart_page.get_cart_product_names).not_to include(product_name)
end

When('I click the {string} button on the cart page') do |button_text|
  if button_text == 'Continue Shopping'
    cart_page.click_continue_shopping
  else
    click_button button_text
  end
end

Then('I should be on the inventory page') do
  expect(inventory_page.on_page?).to be true
end

Then('I should be on the checkout information page') do
  expect(checkout_info_page.on_page?).to be true
end

Then('the following {int} products should be visible in the inventory:') do |count, table|
  expect(inventory_page.product_names.size).to eq(count)
  expected_products = table.hashes.map { |row| row['product_name'] }
  expect(inventory_page.product_names).to match_array(expected_products)
end
