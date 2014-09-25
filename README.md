## Simulacrum

[![Build Status](http://img.shields.io/travis/plasticine/simulacrum.svg?style=flat)][travis]
[![Code Climate](http://img.shields.io/codeclimate/github/plasticine/simulacrum.svg?style=flat)][codeclimate]
[![Code Climate](http://img.shields.io/codeclimate/coverage/github/plasticine/simulacrum.svg?style=flat)][codeclimate]
[![Dependency Status](http://img.shields.io/gemnasium/plasticine/simulacrum.svg?style=flat)][gemnasium]
[![Gem Version](http://img.shields.io/gem/v/simulacrum.svg?style=flat)][gem_version]

**Simulacrum is a UI regression testing tool. It helps you write unit-like tests for
user-interface components in web applications.**

🚧 Simulacrum is still very much a Work In Progress, hopefully it can still be useful for you as I work on making it better and more robust. Feedback and PRs accepted and appreciated.

It is built around common tools such as [RSpec], [Capybara] & [Selenium Webdriver].

Support for 3rd party Selenium Webdriver services (such as [Browserstack], and [Saucelabs]) is provided via additional collaborating gems;

|                  |                                                                                             | Status |
| ---------------- |:------------------------------------------------------------------------------------------- |:------:|
| **Browserstack** | [plasticine/simulacrum-browserstack](https://github.com/plasticine/simulacrum-browserstack) | WIP 🚧 |
| **Saucelabs**    | [plasticine/simulacrum-saucelabs](https://github.com/plasticine/simulacrum-saucelabs)       | WIP 🚧 |

#### Does this sound like something you might be interested in?

**Problem:** Traditional feature testing is only half the picture, it won’t tell you when something looks broken.

- Test your UI components visually
- Know when a UI component is visually altered
- Test component behaviour (JS) that manipulates visual appearance
- Test the resulting output of your UI code (HTML, JS, CSS)

https://speakerdeck.com/justinmorris/ui-regression-testing-for-fun-and-profit

***

## Setup
Simulacrum requires Ruby 1.9.3 or later. To install, add this line to your Gemfile and run `bundle install`:

Create a spec helper file for simulacrum — `simulacrum_helper.rb` — and throw this junk in it:

```ruby
gem 'simulacrum'
```

The next step is to create a `simulacrum_helper.rb` helper file, and then require Simulacrum there:

```ruby
require 'simulacrum'
```

Then you can configure Simulacrum within Rspec:

```ruby
RSpec.configure do |config|
  include Simulacrum

  Simulacrum.configure do |config|
    config.defaults.acceptable_delta = 1 # up to 1% percentage change allowed
    config.defaults.capture_selector = '.components__examples' # CSS selector to crop reference image to
  end
end
```

## Usage

```shell
simulacrum --help
```

### Examples

There are some examples of how Simulacrum can be used in [./examples](https://github.com/plasticine/simulacrum/tree/master/examples)


***

#### Inspiration / Similar tools

- Huxley
- Green Onion


[huxley]: 			      https://github.com/facebook/huxley
[green_onion]:  		  http://intridea.github.io/green_onion
[Browserstack]:       http://www.browserstack.com
[Saucelabs]:          https://saucelabs.com
[RSpec]:              http://rspec.info
[Capybara]:           https://github.com/jnicklas/capybara
[Selenium Webdriver]: http://docs.seleniumhq.org/projects/webdriver/
[codeclimate]:        https://codeclimate.com/github/plasticine/simulacrum
[travis]:             https://travis-ci.org/plasticine/simulacrum
[gemnasium]:          https://gemnasium.com/plasticine/simulacrum
[gem_version]:        http://badge.fury.io/rb/simulacrum
