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
      subject.output.should include('Usage:')
      subject.result.should == false
    end
  end

  describe '--version' do
    let(:option) { '--version' }

    it { subject.result.should == true }
    it { subject.output.should include(Simulacrum::VERSION) }
  end

  describe '--color' do
    it { subject.result.color.should == false }

    context 'when the option is set' do
      let(:option) { '--color' }

      it { subject.result.color.should == true }
    end
  end

  describe '--runner' do
    it { subject.result.runner.should == :default }

    context 'when the option is set' do
      let(:option) { '--runner browserstack' }

      it { subject.result.runner.should == :browserstack }
    end

    context 'when the option is set to an invalid value' do
      let(:option) { '--runner dropbear' }

      it 'throws an InvalidArgument exception' do
        expect { subject.result.runner }.to raise_error(OptionParser::InvalidArgument)
      end
    end
  end

  describe '--username' do
    it { subject.result.username.should be_nil }

    context 'when the option is set' do
      let(:option) { '--username justin' }

      it { subject.result.username.should == 'justin' }
    end
  end

  describe '--apikey' do
    it { subject.result.apikey.should be_nil }

    context 'when the option is set' do
      let(:option) { '--apikey 1234abcd' }

      it { subject.result.apikey.should == '1234abcd' }
    end
  end

  describe '--max-processes' do
    it { subject.result.max_processes.should be_nil }

    context 'when the option is set' do
      let(:option) { '--max-processes 5' }

      it { subject.result.max_processes.should == 5 }
    end
  end
end
