## Simulacrum

An opinionated UI component regression testing tool built to be tightly integrated with RSpec, Selenium and tools you already use.

***

### Installing
`gem 'simulacrum'`

### Configuring

```ruby
RSpec.configure do |config|
  config.include Simulacrum
end
```

Simulacrum can also be configured once included;

```ruby
Simulacrum.configure do |config|
	config.images_path = 'somewhere/example/spec/ui_specs'
	config.acceptable_delta = 2 # allow a maximum of 2% difference
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
