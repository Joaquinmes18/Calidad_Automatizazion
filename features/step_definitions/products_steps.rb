Then('all products should have a name, a price and an {string} button') do |button_text|
  page.all('.inventory_item').each do |item|
    expect(item).to have_css('.inventory_item_name')
    expect(item).to have_css('.inventory_item_price')
    expect(item).to have_button(button_text)
  end
end

When('I sort products by {string}') do |option|
  find('.product_sort_container').find(:option, option).select_option
end

Then('the products should be sorted alphabetically from A to Z') do
  names = page.all('.inventory_item_name').map(&:text)
  expect(names).to eq(names.sort)
end

Then('the products should be sorted alphabetically from Z to A') do
  names = page.all('.inventory_item_name').map(&:text)
  expect(names).to eq(names.sort.reverse)
end

Then('the products should be sorted by price from lowest to highest') do
  prices = page.all('.inventory_item_price').map { |p| p.text.gsub('$', '').to_f }
  expect(prices).to eq(prices.sort)
end

Then('the products should be sorted by price from highest to lowest') do
  prices = page.all('.inventory_item_price').map { |p| p.text.gsub('$', '').to_f }
  expect(prices).to eq(prices.sort.reverse)
end
