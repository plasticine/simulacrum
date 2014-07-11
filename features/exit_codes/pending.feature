Feature: Pending exit code

  The exit code should always be zero when there were pending tests

  Background:
    Given a fixture application "example-app"
    And a file named "spec/ui/ui_component_spec.rb" with:
      """ruby
      require "simulacrum_helper"

      describe 'UI Component' do
        component :ui_component do |options|
          options.url = '/ui_component.html'
        end
        it { should look_the_same }
      end
      """

  Scenario: There is a pending test
    When I run `simulacrum`
    Then the output should contain "1 example, 0 failures, 1 pending"
    And the exit status should be 0
