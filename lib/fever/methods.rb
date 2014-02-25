module Fever
  module Methods
    # Sets the `component` var via `let` in the context to an instance of
    # `Fever::Component`
    def component(name, &block)
      yield(OpenStruct.new)
    end

    def configure_browser(name, &block)
      yield(OpenStruct.new)
    end

    def capture
      # Fever::Image.new
    end

    def it_looks_the_same
      # Fever::Comparator.new
    end
  end
end
