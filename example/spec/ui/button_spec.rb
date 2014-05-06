# encoding: utf-8
require 'simulacrum_helper'

describe "My Button" do
  component :my_button do |options|
    options.url = 'http://127.0.0.1:8080/button.html'
  end

  it { should look_the_same }
end
