Feature: Sauce Demo Products

  In order to browse products in Sauce Demo
  As a logged in customer
  I want to verify the product catalog and sorting functionality

  Background:
    Given I am logged in as "standard_user" with password "secret_sauce"
    And I am on the inventory page

  @smoke
  Scenario: Verify products are displayed after login
    Then the following products should be visible in the inventory with their details:
      | product_name                      | price  | description                                                         |
      | Sauce Labs Backpack               | $29.99 | carry.allTheThings() with the sleek, streamlined Sly Pack           |
      | Sauce Labs Bike Light             | $9.99  | A red light isn't the desired state in testing but it sure helps    |
      | Sauce Labs Bolt T-Shirt           | $15.99 | Get your testing superhero on with the Sauce Labs bolt              |
      | Sauce Labs Fleece Jacket          | $49.99 | It's not every day that you come across a midweight quarter-zip     |
      | Sauce Labs Onesie                 | $7.99  | Rib snap infant onesie for the junior automation engineer           |
      | Test.allTheThings() T-Shirt (Red) | $15.99 | This classic Sauce Labs t-shirt is perfect to wear                  |

  Scenario: Sort products by name from A to Z
    When I sort products by "Name (A to Z)"
    Then the products should be sorted alphabetically from A to Z

  Scenario: Sort products by name from Z to A
    When I sort products by "Name (Z to A)"
    Then the products should be sorted alphabetically from Z to A

  Scenario: Sort products by price from low to high
    When I sort products by "Price (low to high)"
    Then the products should be ordered as follows:
      | product_name                      | price  |
      | Sauce Labs Onesie                 | $7.99  |
      | Sauce Labs Bike Light             | $9.99  |
      | Sauce Labs Bolt T-Shirt           | $15.99 |
      | Test.allTheThings() T-Shirt (Red) | $15.99 |
      | Sauce Labs Backpack               | $29.99 |
      | Sauce Labs Fleece Jacket          | $49.99 |

  Scenario: Sort products by price from high to low
    When I sort products by "Price (high to low)"
    Then the products should be ordered as follows:
      | product_name                      | price  |
      | Sauce Labs Fleece Jacket          | $49.99 |
      | Sauce Labs Backpack               | $29.99 |
      | Sauce Labs Bolt T-Shirt           | $15.99 |
      | Test.allTheThings() T-Shirt (Red) | $15.99 |
      | Sauce Labs Bike Light             | $9.99  |
      | Sauce Labs Onesie                 | $7.99  |
