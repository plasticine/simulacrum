

### Example

A sample test case might look something like this;

```ruby
describe "My Button Component" do
  component :my_button do |component|
    component.url = 'http://localhost:3000/styleguide/components/button'
    component.capture_selector = '.some-class'
  end

  it_looks_the_same capture(:my_button)

  context "Small resolution"
    configure_browser :firefox_small_screen do |browser|
      browser.capability = :firefox
      browser.resolution = [320, 480]
    end

    it_looks_the_same capture(:my_button, with_browser: :firefox_small_screen)
  end

  context "Large resolution"
    configure_browser :chrome_linux do |browser|
      browser.capability = :chrome
      browser.platform = :linux
      browser.resolution = [1024, 768]
    end

    it_looks_the_same capture(:my_button, with_browser: :chrome_linux)
  end

  context "on an iPhone5 running iOS7 in portrait orientation"
    configure_browser :iphone_ios7_portrait do |browser|
      browser.capability = :iphone
      browser.version = 7
      browser.orientation = :portrait
    end

    it_looks_the_same capture(:my_button, with_browser: :iphone_ios7_portrait)
  end
end
```
