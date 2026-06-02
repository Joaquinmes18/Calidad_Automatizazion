Feature: Sauce Demo Menu

  In order to manage my session and application state in Sauce Demo
  As a logged in customer
  I want to verify the hamburger menu functionality

  Background:
    Given I am logged in as "standard_user" with password "secret_sauce"
    And I am on the inventory page

  Scenario: Logout successfully
    When I open the hamburger menu
    And I click "Logout" from the menu
    Then I should be on the Sauce Demo login page
    And the username field should be visible
    And the login button should be visible
