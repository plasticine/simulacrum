# encoding: utf-8
require 'simulacrum_helper'

describe 'My Button' do
  component :my_button do |options|
    options.url = '/button.html'
  end

  it { is_expected.to look_the_same }
end
