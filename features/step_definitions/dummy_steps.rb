# encoding: UTF-8
require 'fileutils'

Given(/^a fixture application$/) do
  step %(a directory named "app")
  target_path = File.join(ENV['PROJECT_ROOT_PATH'], 'fixtures', 'app')
  FileUtils.cp_r(target_path, current_dir)
  step %(I cd to "app")
end

When(/^I debug$/) do
  # rubocop:disable Debugger
  require 'pry'
  binding.pry
end
