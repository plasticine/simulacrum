## Simulacrum

#### Installing
`gem "simulacrum"`

#### Configuring

```ruby
RSpec.configure do |config|
  config.include Simulacrum
end
```

```ruby
Simulacrum.configure do |config|
	config.images_path = 'somewhere/example/spec/ui_specs'
	config.acceptable_delta = 2 # allow a maximum of 2% difference
end
```
