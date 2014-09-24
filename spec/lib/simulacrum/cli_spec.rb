# encoding: UTF-8
require 'spec_helper'
require 'simulacrum/cli'

describe Simulacrum::CLI do
  describe '.execute!' do
    let(:parser)     { stub_const('Simulacrum::CLI::Parser', double) }
    let(:simulacrum) { stub_const('Simulacrum', double) }
    let(:exit_code)  { 0 }

    it 'runs simulacrum with the given args' do
      expect(parser).to receive(:parse).with('--args').and_return(args: true)
      expect(simulacrum).to receive(:run).with(args: true).and_return(exit_code)

      expect(-> { described_class.execute!('--args') }).to raise_error SystemExit
    end
  end
end
