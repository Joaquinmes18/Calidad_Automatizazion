require_relative 'base_page'
require_relative 'login_page'
require_relative 'inventory_page'
require_relative 'cart_page'
require_relative 'checkout_info_page'
require_relative 'checkout_overview_page'
require_relative 'checkout_complete_page'
require_relative 'menu_component'

module PageObjects
  def login_page
    @login_page ||= LoginPage.new
  end

  def inventory_page
    @inventory_page ||= InventoryPage.new
  end

  def cart_page
    @cart_page ||= CartPage.new
  end

  def checkout_info_page
    @checkout_info_page ||= CheckoutInfoPage.new
  end

  def checkout_overview_page
    @checkout_overview_page ||= CheckoutOverviewPage.new
  end

  def checkout_complete_page
    @checkout_complete_page ||= CheckoutCompletePage.new
  end

  def menu_component
    @menu_component ||= MenuComponent.new
  end
end

World(PageObjects)
