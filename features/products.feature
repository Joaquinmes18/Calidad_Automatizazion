Feature: Sauce Demo Products

  In order to browse products in Sauce Demo
  As a logged in customer
  I want to verify the product catalog and sorting functionality

  Background:
    Given I am logged in as "standard_user" with password "secret_sauce"
    And I am on the inventory page

  Scenario: Verify products are displayed after login
    Then I should see 6 products in the inventory
    And all products should have a name, a price and an "Add to cart" button

  Scenario: Sort products by name from A to Z
    When I sort products by "Name (A to Z)"
    Then the products should be sorted alphabetically from A to Z

  Scenario: Sort products by name from Z to A
    When I sort products by "Name (Z to A)"
    Then the products should be sorted alphabetically from Z to A

  Scenario: Sort products by price from low to high
    When I sort products by "Price (low to high)"
    Then the products should be sorted by price from lowest to highest

  Scenario: Sort products by price from high to low
    When I sort products by "Price (high to low)"
    Then the products should be sorted by price from highest to lowest
