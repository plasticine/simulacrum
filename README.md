## Simulacrum

[![Build Status](https://travis-ci.org/plasticine/simulacrum.svg)](https://travis-ci.org/plasticine/simulacrum) [![Code Climate](https://codeclimate.com/github/plasticine/simulacrum/coverage.png)](https://codeclimate.com/github/plasticine/simulacrum) [![Code Climate](https://codeclimate.com/github/plasticine/simulacrum.png)](https://codeclimate.com/github/plasticine/simulacrum) [![Dependency Status](https://gemnasium.com/plasticine/simulacrum.svg)](https://gemnasium.com/plasticine/simulacrum)

Simulacrum is an opinionated UI component regression testing tool built to be tightly integrated with [RSpec], [Capybara], [Selenium Webdriver] and [Browserstack].

### But...why?

Write some words about why this is a good idea.

### Opinions

Simulacrum is a little bit opinionated about a few things;

- selenium webdriver (browserstack)
- testing components

***

## Setup
Simulacrum requires Ruby 1.9.3 or later. To install, add this line to your Gemfile and run `bundle install`:

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

Simulacrum provides a small DSL for configuring and managing UI tests from within Rspec. Basically it boils down to these three methods;

- `component`
- `configure_browser`
- `look_the_same`

***

#### Inspiration / Similar tools

- [Huxley]
- [Green Onion]



[Huxley]: 				https://github.com/facebook/huxley
[Green Onion]:  		http://intridea.github.io/green_onion
[Browserstack]:         http://www.browserstack.com
[RSpec]:                http://rspec.info
[Capybara]:             https://github.com/jnicklas/capybara
[Selenium Webdriver]:   http://docs.seleniumhq.org/projects/webdriver/
