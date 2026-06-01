@cart @login_required
Feature: Sauce Demo Cart

  In order to manage my selected products in Sauce Demo
  As a logged in customer
  I want to verify the shopping cart functionality

  Scenario: Add one product to the cart
    When I add the product "Sauce Labs Backpack" to the cart
    Then the cart badge should show "1"
    And the "Remove" button should be visible for "Sauce Labs Backpack"
    And the cart should contain the product "Sauce Labs Backpack"

  Scenario: Add multiple products to the cart
    When I add the following products to the cart:
      | product_name          |
      | Sauce Labs Backpack   |
      | Sauce Labs Bike Light |
    Then the cart badge should show "2"
    And the cart should contain the following products:
      | product_name          |
      | Sauce Labs Backpack   |
      | Sauce Labs Bike Light |

  Scenario: Remove a product from the cart page
    Given I have added the product "Sauce Labs Backpack" to the cart
    When I go to the cart page
    And I remove "Sauce Labs Backpack" from the cart
    Then the cart should be empty
    And the cart badge should not be visible

  Scenario: Remove one product from a cart with multiple products
    Given I have added the following products to the cart:
      | product_name              |
      | Sauce Labs Backpack       |
      | Sauce Labs Bike Light     |
      | Sauce Labs Bolt T-Shirt   |
    When I go to the cart page
    And I remove "Sauce Labs Bike Light" from the cart
    Then the cart badge should show "2"
    And the cart should contain only the following products:
      | product_name              |
      | Sauce Labs Backpack       |
      | Sauce Labs Bolt T-Shirt   |
    And the cart should not contain the product "Sauce Labs Bike Light"

  Scenario: Remove a product from the inventory page after adding it
    Given I have added the product "Sauce Labs Backpack" to the cart
    When I remove the product "Sauce Labs Backpack" from the inventory
    Then the cart badge should not be visible
    And the "Add to cart" button should be visible for "Sauce Labs Backpack"

  Scenario: Continue shopping from the cart page
    Given I have added the product "Sauce Labs Backpack" to the cart
    When I go to the cart page
    And I click the "Continue Shopping" button on the cart page
    Then I should be on the inventory page
    And I should see 6 products in the inventory

  Scenario: Cart keeps selected products while navigating between inventory and cart
    Given I have added the following products to the cart:
      | product_name          |
      | Sauce Labs Backpack   |
      | Sauce Labs Bike Light |
    When I go to the cart page
    And I click the "Continue Shopping" button on the cart page
    And I go to the cart page
    Then the cart badge should show "2"
    And the cart should contain the following products:
      | product_name          |
      | Sauce Labs Backpack   |
      | Sauce Labs Bike Light |

  Scenario: Checkout can be started with an empty cart
    When I go to the cart page
    And I proceed to checkout
    Then I should be on the checkout information page
