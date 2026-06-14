Then('all products should have a name, a price and an {string} button') do |button_text|
  inventory_page.product_items.each do |item|
    expect(item).to have_css('.inventory_item_name')
    expect(item).to have_css('.inventory_item_price')
    expect(item).to have_button(button_text)
  end
end

When('I sort products by {string}') do |option|
  inventory_page.sort_by(option)
end

Then('the products should be sorted alphabetically from A to Z') do
  names = inventory_page.product_names
  expect(names).to eq(names.sort)
end

Then('the products should be sorted alphabetically from Z to A') do
  names = inventory_page.product_names
  expect(names).to eq(names.sort.reverse)
end

Then('the products should be sorted by price from lowest to highest') do
  prices = inventory_page.product_prices
  expect(prices).to eq(prices.sort)
end

Then('the products should be sorted by price from highest to lowest') do
  prices = inventory_page.product_prices
  expect(prices).to eq(prices.sort.reverse)
end

Then('the following products should be visible in the inventory with their details:') do |table|
  expected_items = table.hashes
  actual_items = inventory_page.product_details_map

  expect(actual_items.size).to eq(expected_items.size)
  
  expected_items.each do |expected|
    actual = actual_items.find { |item| item[:name] == expected['product_name'] }
    expect(actual).not_to be_nil, "Product '#{expected['product_name']}' not found in inventory"
    expect(actual[:price]).to eq(expected['price'])
    expect(actual[:description]).to include(expected['description'])
  end
end

Then('the products should be ordered as follows:') do |table|
  expected_order = table.hashes.map { |row| [row['product_name'], row['price']] }
  actual_order = inventory_page.product_details_map.map { |item| [item[:name], item[:price]] }

  expect(actual_order).to eq(expected_order)
end
