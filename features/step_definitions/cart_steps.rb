When('I add the product {string} to the cart') do |product_name|
  product_item = page.all('.inventory_item').find do |el|
    el.find('.inventory_item_name').text == product_name
  end
  product_item.find('.btn_inventory').click
end

When('I add the following products to the cart:') do |table|
  table.hashes.each do |row|
    product_item = page.all('.inventory_item').find do |el|
      el.find('.inventory_item_name').text == row['product_name']
    end
    product_item.find('.btn_inventory').click
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
  cart_item = page.all('.cart_item').find do |el|
    el.find('.inventory_item_name').text == product_name
  end
  cart_item.find('button', text: 'Remove').click
end

Then('the cart should be empty') do
  expect(page).not_to have_css('.cart_item')
end

When('I click the {string} button on the cart page') do |button_text|
  click_button button_text
end

Then('I should be on the inventory page') do
  expect(page).to have_current_path('/inventory.html', url: false)
  expect(page).to have_css('.inventory_list')
end
