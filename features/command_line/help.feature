@announce
Feature: `--help` option

  The `--help` option should display usage information for simulacrum

  Scenario: Using `--help`
    When I run `simulacrum --help`
    Then the output should contain "Usage: simulacrum [options] [files or directories]"
    And the exit status should be 0
