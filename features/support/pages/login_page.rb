require_relative 'base_page'

class LoginPage < BasePage
  def visit_page
    visit '/'
  end

  def enter_username(username)
    fill_in 'user-name', with: username
  end

  def enter_password(password)
    fill_in 'password', with: password
  end

  def click_login
    click_button 'login-button'
  end

  def login(username, password)
    enter_username(username)
    enter_password(password)
    click_login
  end

  def error_message
    find('[data-test="error"]').text
  end

  def has_error_message?(expected_text)
    has_css?('[data-test="error"]', text: expected_text)
  end

  def username_field_visible?
    has_css?('#user-name', visible: true)
  end

  def login_button_visible?
    has_css?('#login-button', visible: true)
  end
end
