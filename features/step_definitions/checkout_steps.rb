When('I proceed to checkout') do
  click_button 'Checkout'
  expect(page).to have_current_path('/checkout-step-one.html', url: false)
end

When('I complete the checkout information with:') do |table|
  data = table.rows_hash
  fill_in 'first-name',   with: data['first_name']
  fill_in 'last-name',    with: data['last_name']
  fill_in 'postal-code',  with: data['postal_code']
end

When('I submit the checkout information') do
  click_button 'Continue'
end

Then('I should see the checkout error {string}') do |error_message|
  expect(page).to have_css('[data-test="error"]', text: error_message)
end

Then('I should still be on the checkout information page') do
  expect(page).to have_current_path('/checkout-step-one.html', url: false)
  expect(page).to have_field('first-name')
end

Then('I should be on the checkout overview page') do
  expect(page).to have_current_path('/checkout-step-two.html', url: false)
  expect(page).to have_css('.checkout_summary_container')
end

Then('the order should contain the product {string}') do |product_name|
  expect(page).to have_css('.inventory_item_name', text: product_name)
end

When('I finish the purchase') do
  click_button 'Finish'
end

Then('I should see the order confirmation message {string}') do |message|
  expect(page).to have_current_path('/checkout-complete.html', url: false)
  expect(page).to have_css('.complete-header', text: message)
end
