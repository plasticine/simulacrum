# encoding: UTF-8
require 'spec_helper'
require 'simulacrum/driver/local'

describe Simulacrum::Driver::LocalDriver do
  describe '.use' do
    subject { described_class.use }

    it { is_expected.to be_a described_class }
  end
end
