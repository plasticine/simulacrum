require 'fileutils'

Given(/^a fixture application "([^\"]*)"$/) do |fixture_path|
  step %Q(a directory named "#{fixture_path}")

  target_path = File.join(ENV['PROJECT_ROOT_PATH'], 'fixtures', fixture_path)
  FileUtils.cp_r(target_path, current_dir)

  step %Q(I cd to "#{fixture_path}")
end

When(/^I debug$/) do
  # rubocop:disable Debugger
  require 'pry'
  binding.pry
end
