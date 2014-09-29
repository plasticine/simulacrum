# Simulacrum

[![Build Status](http://img.shields.io/travis/plasticine/simulacrum.svg?style=flat)][travis]
[![Code Climate](http://img.shields.io/codeclimate/github/plasticine/simulacrum.svg?style=flat)][codeclimate]
[![Code Climate](http://img.shields.io/codeclimate/coverage/github/plasticine/simulacrum.svg?style=flat)][codeclimate]
[![Dependency Status](http://img.shields.io/gemnasium/plasticine/simulacrum.svg?style=flat)][gemnasium]
[![Gem Version](http://img.shields.io/gem/v/simulacrum.svg?style=flat)][gem_version]

**Simulacrum is a UI regression testing tool. It helps you write unit-like tests for user-interface components in web applications.**

Simulacrum allows you to write RSpec style specs that when run will compare screenshots of components of your UI to their last “Known Good State”, and tell you if they’ve changed.

Simulacrum is built around common tools in the Ruby development world, such as [RSpec], [Capybara] & [Selenium Webdriver].

**🚧 This project is still a Work In Progress™, hopefully it can still be useful for you as I work on making it better and more robust.**

Feedback and PRs accepted and appreciated — see [Development](#Development) below for how to get up and running.

## What problem is this solving?

Traditional UI testing is usually feature and functionality driven, and while this is awesome it is also only really testing half of the actual UI.

Relying solely on functional tests to verify your UI neglects the visual aspect, meaning that a passing functional test can conceal a visually broken piece UI from a user point-of-view (be it from broken CSS or HTML).

At the end of the day if it looks broken it is broken, even if it might still “work”. Frontend tools (particularly CSS, of course) are very brittle and by their nature make it very easy to accidentally break the look of your website.

There is a short slidedeck discussing some of the details and rationale for the project over on [Speakerdeck](https://speakerdeck.com/justinmorris/ui-regression-testing-for-fun-and-profit)

### Simulacrum aims to help you;

- test your UI components visually, and know when they change
- write easy to read specs that don’t require any real special configuration to work
- test your UI and multiple screen sizes (mediaqueries)
- test component behaviour (Javascript) that manipulates visual appearance

## Setup
Simulacrum requires Ruby 1.9.3 or later. To install, add this line to your Gemfile and run `bundle install`:

The next step is to create a `simulacrum_helper.rb` helper file that will help you define any defaults for your tests;

```ruby
require 'simulacrum'

Simulacrum.configure do |config|
  config.component.delta_threshold = 0 # 0% change allowed
  config.component.capture_selector = '.MyComponent' # CSS selector to crop images around
end
```

Simulacrum expects your specs to be under `spec/ui/` and be named `*_spec.rb`.

## Writing Specs

The simplest Simulacrum spec would look something like this;

```ruby
# spec/ui/my_component_spec.rb

require 'simulacrum_helper'

describe 'MyComponent' do
  component :mycomponent do |options|
    options.url = '/link/to/styleguide/example/of/MyComponent.html'
  end

  it { is_expected.to look_the_same }
end
```

## Running Specs

Simulacrum provides a CLI tool to help you run your tests. It implements the same file/directory execution options as RSpec itself, so running a subset of your specs is possible (see below). For a full list of CLI flags run `simulacrum --help`.

##### Running specs
```shell
$ simulacrum                            # Run all specs
$ simulacrum spec/ui/panels             # Run all specs in a directory
$ simulacrum spec/ui/my_button_spec.rb  # Run a specific spec
```

## Examples

There are some examples of how Simulacrum can be used in [examples](./tree/master/examples).

## Remote & Cross-device testing

Support for 3rd party Selenium Webdriver services (such as [Browserstack], and [Saucelabs]) is provided via additional collaborating gems.

|                  |                                      | Status |
| ---------------- |:------------------------------------ |:------:|
| **Browserstack** | [plasticine/simulacrum-browserstack] | WIP 🚧 |
| **Saucelabs**    | [plasticine/simulacrum-saucelabs]    | WIP 🚧 |

## Development

The test suite can be run using `./script/spec`.

***

#### Inspiration / Similar tools

Simulacrum appraoches the idea of UI regression testing by way of screenshots. There are other techniques that could be used to accomplish the same outcome (such as inspecting CSS directly), a good overview of the various techniques is available at [csste.st](http://csste.st/techniques/).

Some of the tools that Simulacrum is most similar to, and takes inspiration from:

- **[Huxley]** `facebook/huxley`
- **[Needle]** `bfirsh/needle`


[plasticine/simulacrum-browserstack]: https://github.com/plasticine/simulacrum-browserstack
[plasticine/simulacrum-saucelabs]:    https://github.com/plasticine/simulacrum-saucelabs
[Needle]:                             https://github.com/bfirsh/needle
[Huxley]:                             https://github.com/facebook/huxley
[Browserstack]:                       http://www.browserstack.com
[Saucelabs]:                          https://saucelabs.com
[RSpec]:                              http://rspec.info
[Capybara]:                           https://github.com/jnicklas/capybara
[Selenium Webdriver]:                 http://docs.seleniumhq.org/projects/webdriver/
[codeclimate]:                        https://codeclimate.com/github/plasticine/simulacrum
[travis]:                             https://travis-ci.org/plasticine/simulacrum
[gemnasium]:                          https://gemnasium.com/plasticine/simulacrum
[gem_version]:                        http://badge.fury.io/rb/simulacrum
