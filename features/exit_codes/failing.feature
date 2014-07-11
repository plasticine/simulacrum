Feature: Failure exit code

  The exit code should always be non-zero (1) when there are failing tests

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

  Scenario: There are failing tests
    Given a reference image for "ui_component" with content: "diff.png"
    When I run `simulacrum`
    Then the output should contain "1 example, 1 failure"
    And the exit status should be 1
