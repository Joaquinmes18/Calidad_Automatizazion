require_relative 'base_page'

class CheckoutCompletePage < BasePage
  def visit_page
    visit '/checkout-complete.html'
  end

  def on_page?
    has_current_path?('/checkout-complete.html', url: false)
  end

  def confirmation_message
    find('.complete-header').text
  end

  def has_confirmation_message?(expected_message)
    has_css?('.complete-header', text: expected_message)
  end
end
