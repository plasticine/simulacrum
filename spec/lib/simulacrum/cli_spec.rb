# encoding: UTF-8
require 'spec_helper'
require 'simulacrum/cli'

describe Simulacrum::CLI do
  describe '.run' do
    let!(:parser)     { stub_const('Simulacrum::CLI::Parser', double) }
    let!(:simulacrum) { stub_const('Simulacrum', double) }

    it 'runs simulacrum with the given args' do
      parser.should_receive(:parse).with('--args').and_return(args: true)
      simulacrum.should_receive(:run).with(args: true).and_return('tracer')

      described_class.run('--args').should == 'tracer'
    end
  end
end
