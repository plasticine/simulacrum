# encoding: UTF-8

module Capybara
  module Selenium
    # Monkey patch the Capybara Driver class to ensure that we can call `quit`
    # at the end of a parallel process run and not generate errors if capybara
    # then attempts to quit.
    #
    # We need to do this so that sessions are terminated as early as possible
    # at the remote end.
    class Driver < Capybara::Driver::Base
      def quit
        @browser.quit if @browser
      rescue Errno::ECONNREFUSED,
             ::Selenium::WebDriver::Error::UnknownError
        # Browser must have already gone
      ensure
        @browser = nil
      end
    end
  end
end
