require_relative 'base_page'

class CheckoutInfoPage < BasePage
  def visit_page
    visit '/checkout-step-one.html'
  end

  def on_page?
    has_current_path?('/checkout-step-one.html', url: false) &&
      has_field?('first-name') &&
      has_field?('last-name') &&
      has_field?('postal-code')
  end

  def fill_information(first_name, last_name, postal_code)
    fill_in 'first-name', with: first_name
    fill_in 'last-name', with: last_name
    fill_in 'postal-code', with: postal_code
  end

  def click_continue
    find('[data-test="continue"]').click
  end

  def click_cancel
    find('[data-test="cancel"]').click
  end

  def error_message
    find('[data-test="error"]').text
  end

  def has_error_message?(expected_text)
    has_css?('[data-test="error"]', text: expected_text)
  end
end
