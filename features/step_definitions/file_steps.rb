Given(/^a (reference|candidate) image for "([^"]*)" with content: "([^"]*)"$/) do |type, component_name, fixture_path|
  fixture_path = File.join(ENV['PROJECT_ROOT_PATH'], 'fixtures', fixture_path)
  destination_path = File.join('spec/ui/references/', component_name, 'sauce', "#{type}.png")
  rel_destination_path = File.join(current_dir, destination_path)
  FileUtils.mkdir_p(File.dirname(rel_destination_path))
  FileUtils.cp(fixture_path, rel_destination_path)
  step %Q(a #{type} for "#{component_name}" should exist)
end

Then(/^a (reference|candidate) for "(.*?)" should not exist$/) do |type, component_name|
  path = File.join('spec/ui/references/', component_name, 'sauce', "#{type}.png")
  step %Q(a file named "#{path}" should not exist)
end

Then(/^a (reference|candidate) for "(.*?)" should exist$/) do |type, component_name|
  path = File.join('spec/ui/references/', component_name, 'sauce', "#{type}.png")
  step %Q(a file named "#{path}" should exist)
end
