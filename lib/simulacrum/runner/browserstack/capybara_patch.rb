class Capybara::Selenium::Driver < Capybara::Driver::Base
  def quit
    @browser.quit if @browser
  rescue Errno::ECONNREFUSED,
         Selenium::WebDriver::Error::UnknownError
    # Browser must have already gone
  ensure
    @browser = nil
  end
end
