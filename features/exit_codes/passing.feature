@announce
Feature: Passing exit code

  The exit code should always be zero when the tests pass

  Background:
    Given a fixture application
    And a file named "spec/ui/ui_component_spec.rb" with:
      """ruby
      require 'simulacrum_helper'

      describe 'UI Component' do
        component :ui_component do |options|
          options.url = '/ui_component.html'
        end
        it { should look_the_same }
      end
      """

  Scenario: Passing tests
    Given a reference image for "ui_component" with content: "a1.png"
    When I run `simulacrum`
    Then the exit status should be 0
    And the output should contain "1 example, 0 failures"
    And the output should not contain "pending"
