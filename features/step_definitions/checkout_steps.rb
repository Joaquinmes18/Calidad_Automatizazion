require 'bigdecimal'

def money_from(selector)
  text = find(selector).text
  BigDecimal(text.match(/\$([\d.]+)/)[1])
end

When('I proceed to checkout') do
  find('[data-test="checkout"]').click
  expect(page).to have_current_path('/checkout-step-one.html', url: false)
end

When('I complete the checkout information with:') do |table|
  data = table.rows_hash
  fill_in 'first-name', with: data['first_name']
  fill_in 'last-name', with: data['last_name']
  fill_in 'postal-code', with: data['postal_code']
end

When('I submit the checkout information') do
  find('[data-test="continue"]').click
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

  fill_in 'first-name', with: checkout_data['first_name']
  fill_in 'last-name', with: checkout_data['last_name']
  fill_in 'postal-code', with: checkout_data['postal_code']
  find('[data-test="continue"]').click
end

When('I cancel checkout from the information page') do
  find('[data-test="cancel"]').click
end

Then('I should see the checkout error {string}') do |error_message|
  expect(page).to have_css('[data-test="error"]', text: error_message)
end

Then('I should still be on the checkout information page') do
  expect(page).to have_current_path('/checkout-step-one.html', url: false)
  expect(page).to have_field('first-name')
  expect(page).to have_field('last-name')
  expect(page).to have_field('postal-code')
end

Then('I should be on the cart page') do
  expect(page).to have_current_path('/cart.html', url: false)
  expect(page).to have_css('.cart_list')
end

Then('I should be on the checkout overview page') do
  expect(page).to have_current_path('/checkout-step-two.html', url: false)
  expect(page).to have_css('.checkout_summary_container')
end

Then('the order should contain the product {string}') do |product_name|
  expect(page).to have_css('.inventory_item_name', text: product_name)
end

When('I finish the purchase') do
  find('[data-test="finish"]').click
end

Then('I should see the order confirmation message {string}') do |message|
  expect(page).to have_current_path('/checkout-complete.html', url: false)
  expect(page).to have_css('.complete-header', text: message)
end

Then('the checkout total should equal the item total plus tax') do
  item_total = money_from('[data-test="subtotal-label"]')
  tax = money_from('[data-test="tax-label"]')
  total = money_from('[data-test="total-label"]')

  expect(item_total + tax).to eq(total)
end
