require_relative 'base_page'

class MenuComponent < BasePage
  def open
    find('#react-burger-menu-btn').click
    expect(page).to have_css('.bm-menu-wrap', visible: true)
  end

  def close
    find('#react-burger-cross-btn').click
  end

  def logout
    find('#logout_sidebar_link').click
  end

  def reset_app_state
    find('#reset_sidebar_link').click
  end
end
