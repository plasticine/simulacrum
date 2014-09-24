# encoding: UTF-8
require 'spec_helper'
require 'simulacrum/driver'

describe Simulacrum::Driver do
  describe '.use' do
    subject { described_class.use }

    it { is_expected.to be_a described_class }
  end
end
