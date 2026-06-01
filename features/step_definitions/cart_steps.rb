def inventory_item_for(product_name)
  page.all('.inventory_item').find do |item|
    item.has_css?('.inventory_item_name', text: product_name, exact_text: true)
  end
end

def cart_item_for(product_name)
  page.all('.cart_item').find do |item|
    item.has_css?('.inventory_item_name', text: product_name, exact_text: true)
  end
end

When('I add the product {string} to the cart') do |product_name|
  inventory_item_for(product_name).find('button[data-test^="add-to-cart"]').click
end

When('I add the following products to the cart:') do |table|
  table.hashes.each do |row|
    inventory_item_for(row['product_name']).find('button[data-test^="add-to-cart"]').click
  end
end

Given('I have added the following products to the cart:') do |table|
  table.hashes.each do |row|
    inventory_item_for(row['product_name']).find('button[data-test^="add-to-cart"]').click
  end
end

Then('the cart should contain the product {string}') do |product_name|
  find('.shopping_cart_link').click
  expect(page).to have_current_path('/cart.html', url: false)
  expect(page).to have_css('.inventory_item_name', text: product_name)
end

Then('the cart should contain the following products:') do |table|
  find('.shopping_cart_link').click
  expect(page).to have_current_path('/cart.html', url: false)
  table.hashes.each do |row|
    expect(page).to have_css('.inventory_item_name', text: row['product_name'])
  end
end

When('I go to the cart page') do
  find('.shopping_cart_link').click
  expect(page).to have_current_path('/cart.html', url: false)
end

When('I remove {string} from the cart') do |product_name|
  cart_item_for(product_name).find('button[data-test^="remove"]').click
end

When('I remove the product {string} from the inventory') do |product_name|
  inventory_item_for(product_name).find('button[data-test^="remove"]').click
end

Then('the cart should be empty') do
  expect(page).not_to have_css('.cart_item')
end

Then('the cart should contain only the following products:') do |table|
  expected_products = table.hashes.map { |row| row['product_name'] }
  actual_products = page.all('.cart_item .inventory_item_name').map(&:text)

  expect(actual_products).to match_array(expected_products)
end

Then('the cart should not contain the product {string}') do |product_name|
  expect(page).not_to have_css('.cart_item .inventory_item_name', text: product_name)
end

When('I click the {string} button on the cart page') do |button_text|
  click_button button_text
end

Then('I should be on the inventory page') do
  expect(page).to have_current_path('/inventory.html', url: false)
  expect(page).to have_css('.inventory_list')
end

Then('I should be on the checkout information page') do
  expect(page).to have_current_path('/checkout-step-one.html', url: false)
  expect(page).to have_field('first-name')
  expect(page).to have_field('last-name')
  expect(page).to have_field('postal-code')
end
