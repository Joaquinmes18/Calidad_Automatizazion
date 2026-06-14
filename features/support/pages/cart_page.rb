require_relative 'base_page'

class CartPage < BasePage
  def visit_page
    visit '/cart.html'
  end

  def on_page?
    has_current_path?('/cart.html', url: false)
  end

  def cart_items
    all('.cart_item')
  end

  def find_cart_item(product_name)
    all('.cart_item').find do |item|
      item.has_css?('.inventory_item_name', text: product_name, exact_text: true)
    end
  end

  def get_cart_product_names
    all('.cart_item .inventory_item_name').map(&:text)
  end

  def remove_product(product_name)
    item = find_cart_item(product_name)
    raise "Product '#{product_name}' not found in cart" unless item
    item.find('button[data-test^="remove"]').click
  end

  def click_continue_shopping
    click_button 'Continue Shopping'
  end

  def click_checkout
    find('[data-test="checkout"]').click
  end

  def empty?
    !has_css?('.cart_item')
  end
end
