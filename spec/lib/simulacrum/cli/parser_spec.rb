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
      subject.output.should include("Usage:")
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

  describe '--browserstack' do
    it { subject.result.browserstack.should == false }

    context 'when the option is set' do
      let(:option) { '--browserstack' }

      it { subject.result.browserstack.should == true }
    end
  end
end
