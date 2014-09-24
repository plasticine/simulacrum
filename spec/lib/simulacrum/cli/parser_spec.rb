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

  describe '--runner' do
    it { expect(subject.result.runner).to be_nil }

    context 'when the option is set' do
      let(:option) { '--runner browserstack' }

      it { expect(subject.result.runner).to eq(:browserstack) }
    end

    context 'when the option is set to an invalid value' do
      let(:option) { '--runner dropbear' }

      it 'throws an InvalidArgument exception' do
        expect { subject.result.runner }.to raise_error(OptionParser::InvalidArgument)
      end
    end
  end

  describe '--username' do
    it { expect(subject.result.username).to be_nil }

    context 'when the option is set' do
      let(:option) { '--username justin' }

      it { expect(subject.result.username).to eq('justin') }
    end
  end

  describe '--apikey' do
    it { expect(subject.result.apikey).to be_nil }

    context 'when the option is set' do
      let(:option) { '--apikey 1234abcd' }

      it { expect(subject.result.apikey).to eq('1234abcd') }
    end
  end

  describe '--max-processes' do
    it { expect(subject.result.max_processes).to be_nil }

    context 'when the option is set' do
      let(:option) { '--max-processes 5' }

      it { expect(subject.result.max_processes).to eq(5) }
    end
  end

  describe '--browser' do
    it { expect(subject.result.browser).to be_nil }

    context 'when the option is set' do
      let(:option) { '--browser firefox' }

      it { expect(subject.result.browser).to eq(:firefox) }
    end
  end
end
