Feature: Sauce Demo Checkout

  In order to purchase products in Sauce Demo
  As a logged in customer
  I want to verify the checkout process

  Background:
    Given I am logged in as "standard_user" with password "secret_sauce"
    And I have added the product "Sauce Labs Backpack" to the cart
    And I am on the cart page

  Scenario: Checkout fails when first name is empty
    When I proceed to checkout
    And I complete the checkout information with:
      | first_name  |       |
      | last_name   | Perez |
      | postal_code | 00100 |
    And I submit the checkout information
    Then I should see the checkout error "Error: First Name is required"
    And I should still be on the checkout information page

  Scenario: Complete a purchase successfully
    When I proceed to checkout
    And I complete the checkout information with:
      | first_name  | Juan  |
      | last_name   | Perez |
      | postal_code | 00100 |
    And I submit the checkout information
    Then I should be on the checkout overview page
    And the order should contain the product "Sauce Labs Backpack"
    When I finish the purchase
    Then I should see the order confirmation message "Thank you for your order!"
