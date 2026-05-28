Feature: Sauce Demo Menu

  In order to manage my session and application state in Sauce Demo
  As a logged in customer
  I want to verify the hamburger menu functionality

  Background:
    Given I am logged in as "standard_user" with password "secret_sauce"
    And I am on the inventory page

  Scenario: Reset app state from the menu
    Given I have added the product "Sauce Labs Backpack" to the cart
    When I open the hamburger menu
    And I click "Reset App State" from the menu
    And I close the hamburger menu
    Then the cart badge should not be visible
    And the "Add to cart" button should be visible for "Sauce Labs Backpack"

  Scenario: Logout successfully
    When I open the hamburger menu
    And I click "Logout" from the menu
    Then I should be on the Sauce Demo login page
    And the username field should be visible
    And the login button should be visible
