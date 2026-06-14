@checkout
Feature: Sauce Demo Checkout

  In order to purchase products in Sauce Demo
  As a logged in customer
  I want to verify the checkout process

  Background:
    Given I am logged in as "standard_user" with password "secret_sauce"
    And I am on the inventory page
    And I add the product "Sauce Labs Backpack" to the cart
    And I go to the cart page
    And I proceed to checkout

  Scenario Outline: Checkout requires mandatory customer information
    When I try to continue checkout with missing "<missing_field>"
    Then I should see the checkout error "<error_message>"
    And I should still be on the checkout information page

    Examples:
      | missing_field | error_message                  |
      | first name    | Error: First Name is required  |
      | last name     | Error: Last Name is required   |
      | postal code   | Error: Postal Code is required |

  @smoke
  Scenario: Complete a purchase successfully
    When I provide valid checkout information:
      | first_name  | Juan  |
      | last_name   | Perez |
      | postal_code | 00100 |
    Then I should be on the checkout overview page
    And the order should contain the product "Sauce Labs Backpack"
    When I finish the purchase
    Then I should see the order confirmation message "Thank you for your order!"

  Scenario: Checkout overview total matches item total plus tax
    When I provide valid checkout information:
      | first_name  | Juan  |
      | last_name   | Perez |
      | postal_code | 00100 |
    Then I should be on the checkout overview page
    And the checkout total should match:
      | item_total | $29.99 |
      | tax        | $2.40  |
      | total      | $32.39 |

  Scenario: Cancel checkout returns to the cart
    When I cancel checkout from the information page
    Then I should be on the cart page
    And the cart should contain the product "Sauce Labs Backpack"
