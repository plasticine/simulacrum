# encoding: UTF-8
require 'spec_helper'
require 'stringio'
require 'simulacrum/cli/parser'

describe Simulacrum::CLI::Parser do
  def run(args)
    output = StringIO.new('')
    result = Simulacrum::CLI::Parser.new(output).parse(args.split(/\s+/m))

    parser = OpenStruct.new
    parser.output = output.string
    parser.result = result
    parser
  end

  let(:option) { '' }
  subject { run(option) }

  describe 'invalid options' do
    let(:option) { '--velociraptors' }

    it 'handles invalid options by showing help' do
      expect(subject.output).to include('Usage:')
      expect(subject.result).to eq(false)
    end
  end

  describe '--version' do
    let(:option) { '--version' }

    it { expect(subject.result).to eq(true) }
    it { expect(subject.output).to include(Simulacrum::VERSION) }
  end

  describe '--color' do
    it { expect(subject.result.color).to eq(false) }

    context 'when the option is set' do
      let(:option) { '--color' }

      it { expect(subject.result.color).to eq(true) }
    end
  end

  describe '--verbose' do
    it { expect(subject.result.verbose).to eq(false) }

    context 'when the option is set' do
      let(:option) { '--verbose' }

      it { expect(subject.result.verbose).to eq(true) }
    end
  end
end
