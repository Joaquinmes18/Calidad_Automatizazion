Feature: Sauce Demo Verify Login

  In order to buy products in Sauce Demo

  As a registered customer

  I want to verify the login functionality with different types of users


@smoke
Scenario Outline: Verify login with different user types

  Given I am on the Sauce Demo login page

  When I enter "<username>" as username

  And I enter "<password>" as password

  And I click the "Login" button on the login form

  Then the login result should be "<expected_result>"


  Examples:

    | username                  | password     | expected_result                                                            |
    | standard_user             | secret_sauce | redirected to inventory page                                               |
    | locked_out_user           | secret_sauce | Epic sadface: Sorry, this user has been locked out.                        |
    | problem_user              | secret_sauce | redirected to inventory page                                               |
    | performance_glitch_user   | secret_sauce | redirected to inventory page                                               |
    | error_user                | secret_sauce | redirected to inventory page                                               |
    | visual_user               | secret_sauce | redirected to inventory page                                               |
    | invalid_user              | secret_sauce | Epic sadface: Username and password do not match any user in this service  |
    | standard_user             | wrong_pass   | Epic sadface: Username and password do not match any user in this service  |
    |                            | secret_sauce | Epic sadface: Username is required                                         |
    | standard_user             |              | Epic sadface: Password is required                                         |


