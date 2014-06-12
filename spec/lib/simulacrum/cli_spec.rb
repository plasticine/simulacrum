# encoding: UTF-8
require 'spec_helper'
require 'simulacrum/cli'

describe Simulacrum::CLI do
  describe '.run' do
    let!(:parser)     { stub_const('Simulacrum::CLI::Parser', double) }
    let!(:simulacrum) { stub_const('Simulacrum', double) }

    it 'runs simulacrum with the given args' do
      expect(parser).to receive(:parse).with('--args').and_return(args: true)
      expect(simulacrum).to receive(:run).with(args: true).and_return('tracer')

      expect(described_class.run('--args')).to eq('tracer')
    end
  end
end
