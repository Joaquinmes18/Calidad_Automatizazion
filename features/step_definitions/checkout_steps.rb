When('I proceed to checkout') do
  cart_page.click_checkout
  expect(checkout_info_page.on_page?).to be true
end

When('I complete the checkout information with:') do |table|
  data = table.rows_hash
  checkout_info_page.fill_information(data['first_name'], data['last_name'], data['postal_code'])
end

When('I submit the checkout information') do
  checkout_info_page.click_continue
end

When('I provide valid checkout information:') do |table|
  step 'I complete the checkout information with:', table
  step 'I submit the checkout information'
end

When('I try to continue checkout with missing {string}') do |missing_field|
  checkout_data = {
    'first_name' => 'Juan',
    'last_name' => 'Perez',
    'postal_code' => '00100'
  }

  case missing_field
  when 'first name'
    checkout_data['first_name'] = ''
  when 'last name'
    checkout_data['last_name'] = ''
  when 'postal code'
    checkout_data['postal_code'] = ''
  else
    raise "Unsupported checkout field: #{missing_field}"
  end

  checkout_info_page.fill_information(
    checkout_data['first_name'],
    checkout_data['last_name'],
    checkout_data['postal_code']
  )
  checkout_info_page.click_continue
end

When('I cancel checkout from the information page') do
  checkout_info_page.click_cancel
end

Then('I should see the checkout error {string}') do |error_message|
  expect(checkout_info_page.has_error_message?(error_message)).to be true
end

Then('I should still be on the checkout information page') do
  expect(checkout_info_page.on_page?).to be true
end

Then('I should be on the cart page') do
  expect(cart_page.on_page?).to be true
end

Then('I should be on the checkout overview page') do
  expect(checkout_overview_page.on_page?).to be true
end

Then('the order should contain the product {string}') do |product_name|
  expect(checkout_overview_page.has_product?(product_name)).to be true
end

When('I finish the purchase') do
  checkout_overview_page.click_finish
end

Then('I should see the order confirmation message {string}') do |message|
  expect(checkout_complete_page.on_page?).to be true
  expect(checkout_complete_page.has_confirmation_message?(message)).to be true
end

Then('the checkout total should equal the item total plus tax') do
  expect(checkout_overview_page.item_total + checkout_overview_page.tax).to eq(checkout_overview_page.total)
end

Then('the checkout total should match:') do |table|
  expected = table.rows_hash
  expected_item_total = BigDecimal(expected['item_total'].gsub('$', ''))
  expected_tax = BigDecimal(expected['tax'].gsub('$', ''))
  expected_total = BigDecimal(expected['total'].gsub('$', ''))

  expect(checkout_overview_page.item_total).to eq(expected_item_total)
  expect(checkout_overview_page.tax).to eq(expected_tax)
  expect(checkout_overview_page.total).to eq(expected_total)
  expect(checkout_overview_page.item_total + checkout_overview_page.tax).to eq(checkout_overview_page.total)
end
