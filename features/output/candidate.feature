Feature: candidate image output

  A candidate image should be produced when there is no reference image present
  or if the diff threshold is met.

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

  Scenario: There is already a reference, and there is no diff so a candidate should not be created
    Given a reference image for "ui_component" with content: "a1.png"
    When I run `simulacrum`
    Then a candidate for "ui_component" should not exist

  Scenario: There is no reference present so a candidate should be created
    When I run `simulacrum`
    Then a candidate for "ui_component" should exist

  Scenario: There is a diff when the test is run so a candidate should be created
    Given a reference image for "ui_component" with content: "diff.png"
    When I run `simulacrum`
    Then a candidate for "ui_component" should exist
