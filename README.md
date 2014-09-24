## Simulacrum

[![Build Status](http://img.shields.io/travis/plasticine/simulacrum.svg?style=flat)][travis]
[![Code Climate](http://img.shields.io/codeclimate/github/plasticine/simulacrum.svg?style=flat)][codeclimate]
[![Code Climate](http://img.shields.io/codeclimate/coverage/github/plasticine/simulacrum.svg?style=flat)][codeclimate]
[![Dependency Status](http://img.shields.io/gemnasium/plasticine/simulacrum.svg?style=flat)][gemnasium]
[![Gem Version](http://img.shields.io/gem/v/simulacrum.svg?style=flat)][gem_version]

**Simulacrum is a UI regression testing tool. It helps you write unit-like tests for
user-interface components in web applications.**

It is built around common tools such as [RSpec], [Capybara] & [Selenium Webdriver].

Support for 3rd party Selenium Webdriver services (such as [Browserstack], and [Saucelabs]) is provided via additional collaborating gems;

|                  |                                                                                             | Status |
| ---------------- |:------------------------------------------------------------------------------------------- |:------:|
| **Browserstack** | [plasticine/simulacrum-browserstack](https://github.com/plasticine/simulacrum-browserstack) | WIP 🚧 |
| **Saucelabs**    | [plasticine/simulacrum-saucelabs](https://github.com/plasticine/simulacrum-saucelabs)       | WIP 🚧 |

#### Does this sound like something you might be interested in?

- Test your UI components visually
- Know when a component is visually altered
- Integrate with
- Test component behaviour (JS) that manipulates visual appearance

***

### UI Regression Testing

Explain the use-case better.

### Opinions

Simulacrum is a little bit opinionated about a few things;

- selenium webdriver (browserstack)
- testing components

It would be good to explain these opinions, the reason for them and why they are good.

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




<!-- Simulacrum provides a small DSL for configuring and managing UI tests from within Rspec. Basically it boils down to these three methods;

- `component`
- `configure_browser`
- `look_the_same` -->

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
