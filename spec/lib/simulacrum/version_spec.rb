# encoding: UTF-8
require 'simulacrum/version'

describe Simulacrum do
  describe 'PACKAGE' do
    it { expect(Simulacrum::PACKAGE).to eq('simulacrum') }
  end

  describe 'VERSION' do
    it { expect(Simulacrum::VERSION).to eq('0.3.0') }
  end
end
