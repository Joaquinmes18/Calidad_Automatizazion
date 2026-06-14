require_relative 'base_page'
require 'bigdecimal'

class CheckoutOverviewPage < BasePage
  def visit_page
    visit '/checkout-step-two.html'
  end

  def on_page?
    has_current_path?('/checkout-step-two.html', url: false) && has_css?('.checkout_summary_container')
  end

  def money_from(selector)
    text = find(selector).text
    BigDecimal(text.match(/\$([\d.]+)/)[1])
  end

  def item_total
    money_from('[data-test="subtotal-label"]')
  end

  def tax
    money_from('[data-test="tax-label"]')
  end

  def total
    money_from('[data-test="total-label"]')
  end

  def has_product?(product_name)
    has_css?('.inventory_item_name', text: product_name)
  end

  def click_finish
    find('[data-test="finish"]').click
  end

  def click_cancel
    find('[data-test="cancel"]').click
  end
end
