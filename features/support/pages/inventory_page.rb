require_relative 'base_page'

class InventoryPage < BasePage
  def visit_page
    visit '/inventory.html'
  end

  def on_page?
    has_current_path?('/inventory.html', url: false) && has_css?('.inventory_list')
  end

  def product_items
    all('.inventory_item')
  end

  def find_product_item(product_name)
    all('.inventory_item').find do |item|
      item.has_css?('.inventory_item_name', text: product_name, exact_text: true)
    end
  end

  def add_product_to_cart(product_name)
    item = find_product_item(product_name)
    raise "Product '#{product_name}' not found" unless item
    item.find('button[data-test^="add-to-cart"]').click
  end

  def remove_product_from_inventory(product_name)
    item = find_product_item(product_name)
    raise "Product '#{product_name}' not found" unless item
    item.find('button[data-test^="remove"]').click
  end

  def add_button_visible?(product_name)
    item = find_product_item(product_name)
    return false unless item
    item.has_button?('Add to cart')
  end

  def remove_button_visible?(product_name)
    item = find_product_item(product_name)
    return false unless item
    item.has_button?('Remove')
  end

  def product_names
    all('.inventory_item_name').map(&:text)
  end

  def product_prices
    all('.inventory_item_price').map { |p| p.text.gsub('$', '').to_f }
  end

  def sort_by(option)
    find('.product_sort_container').find(:option, option).select_option
  end

  def click_cart
    find('.shopping_cart_link').click
  end

  def has_cart_badge?
    has_css?('.shopping_cart_badge')
  end

  def cart_badge_text
    find('.shopping_cart_badge').text
  end

  def product_details_map
    all('.inventory_item').map do |item|
      {
        name: item.find('.inventory_item_name').text,
        price: item.find('.inventory_item_price').text,
        description: item.find('.inventory_item_desc').text
      }
    end
  end
end
