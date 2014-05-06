## Simulacrum

An opinionated UI component regression testing tool built to be tightly integrated with RSpec, Selenium and tools you already use.

***

[![Build Status](https://travis-ci.org/plasticine/simulacrum.svg)](https://travis-ci.org/plasticine/simulacrum) [![Code Climate](https://codeclimate.com/github/plasticine/simulacrum/coverage.png)](https://codeclimate.com/github/plasticine/simulacrum) [![Code Climate](https://codeclimate.com/github/plasticine/simulacrum.png)](https://codeclimate.com/github/plasticine/simulacrum)

### Installing
`gem 'simulacrum'`

### Configuring

```ruby
RSpec.configure do |config|
  include Simulacrum
end
```

Simulacrum can also be configured once included;

```ruby
RSpec.configure do |config|
	include Simulacrum

	Simulacrum.configure do |simulacrum|
		simulacrum.images_path = 'somewhere/example/spec/ui_specs'
		simulacrum.acceptable_delta = 0.1 # allow a maximum of 0.1% difference
		config.defaults.capture_selector = '.kayessess__examples'
	end
end
```

### Opinions

### Usage

Simulacrum provides a small DSL for configuring and managing UI tests from within Rspec. Basically it boils down to these three methods;

- `component`
- `configure_browser`
- `look_the_same`

#### Inspiration

- Huxley
- Green Onion
