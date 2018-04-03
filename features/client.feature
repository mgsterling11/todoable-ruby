Feature: Client
  In order to create an HTTP endpoint wrapper
  As a CLI
  I want to create the same outcomes as hitting the API directly

  Scenario: Creating a new list
    When I run `todoable create_list "Groceries" --username "km.nwani@gmail.com" --pass "todoable"`
    Then the output should contain "Groceries"