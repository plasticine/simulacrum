require_relative '../../../lib/simulacrum/version'

describe Simulacrum do
  describe 'PACKAGE' do
    it { Simulacrum::PACKAGE.should == 'simulacrum' }
  end

  describe 'VERSION' do
    it { Simulacrum::VERSION.should == '0.2.0' }
  end
end
