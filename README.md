## Simulacrum

[![Build Status](https://travis-ci.org/plasticine/simulacrum.svg)][travis]
[![Code Climate](https://codeclimate.com/github/plasticine/simulacrum/coverage.png)][codeclimate]
[![Code Climate](https://codeclimate.com/github/plasticine/simulacrum.png)][codeclimate]
[![Dependency Status](https://gemnasium.com/plasticine/simulacrum.svg)][gemnasium]
[![Gem Version](https://badge.fury.io/rb/simulacrum.svg)][gem_version]

Simulacrum is an opinionated UI component regression testing tool built to be tightly integrated with [RSpec], [Capybara], [Selenium Webdriver] & [Browserstack].

__Simulacrum is still very much in development. There will probably be breaking changes, and the API will almost certainly change.__

***

### 🚧 But...why?

Explain the use-case better.

### 🚧 Opinions

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

- [Huxley]
- [Green Onion]

[Huxley]: 				    https://github.com/facebook/huxley
[Green Onion]:  		  http://intridea.github.io/green_onion
[Browserstack]:       http://www.browserstack.com
[RSpec]:              http://rspec.info
[Capybara]:           https://github.com/jnicklas/capybara
[Selenium Webdriver]: http://docs.seleniumhq.org/projects/webdriver/
[codeclimate]:        https://codeclimate.com/github/plasticine/simulacrum
[travis]:             https://travis-ci.org/plasticine/simulacrum
[gemnasium]:          https://gemnasium.com/plasticine/simulacrum
[gem_version]:        http://badge.fury.io/rb/simulacrum
