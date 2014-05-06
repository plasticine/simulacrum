# encoding: UTF-8
require_relative '../../../lib/simulacrum/component'
require 'ostruct'

describe Simulacrum::Component do
  let(:name) { 'My Component' }
  let(:references_path) { 'references_path' }
  let(:options) do
    Struct.new(:url).new('http://localhost')
  end
  let(:configuration) do
    configuration = OpenStruct.new
    configuration.references_path = references_path
    configuration
  end

  subject(:component) { described_class.new(name, options) }

  before(:each) do
    Simulacrum.stub(:configuration) { configuration }
  end

  describe '#render' do
    pending
  end

  describe '#reference?' do
    let(:reference_filename) { 'reference' }
    subject { component.reference? }

    before(:each) do
      configuration.reference_filename = reference_filename
    end

    it { should == false }

    context 'when a reference image exists' do
      before(:each) do
        File.stub(:exist?).with("#{references_path}/#{name}/rack_test/#{reference_filename}.png") { true }
      end

      it { should == true }
    end
  end

  describe '#candidate?' do
    let(:candidate_filename) { 'candidate' }
    subject { component.candidate? }

    before(:each) do
      configuration.candidate_filename = 'candidate'
    end

    it { should == false }

    context 'when a candidate image exists' do
      before(:each) do
        File.stub(:exist?).with("#{references_path}/#{name}/rack_test/#{candidate_filename}.png") { true }
      end

      it { should == true }
    end
  end

  describe '#diff?' do
    let(:diff_filename) { 'diff' }
    subject { component.diff? }

    before(:each) do
      configuration.diff_filename = diff_filename
    end

    it { should == false }

    context 'when a diff image exists' do
      before(:each) do
        File.stub(:exist?).with("#{references_path}/#{name}/rack_test/#{diff_filename}.png") { true }
      end

      it { should == true }
    end
  end

  describe '#acceptable_delta' do

  end

  describe '#reference_path' do

  end

  describe '#candidate_path' do

  end

  describe '#diff_path' do

  end

  describe '#remove_candidate' do

  end

  describe '#remove_diff' do

  end
end
