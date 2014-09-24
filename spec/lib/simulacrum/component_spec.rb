# encoding: UTF-8
require 'spec_helper'
require 'simulacrum/component'
require 'ostruct'

describe Simulacrum::Component do
  let(:name) { 'MyComponent' }
  let(:driver_name) { 'MyDriver' }
  let(:references_path) { 'references' }
  let(:configuration) { OpenStruct.new references_path: references_path }
  let(:options) do
    options = OpenStruct.new
    options.url = 'http://localhost'
    options
  end
  let(:renderer) { double('Simulacrum::Renderer') }

  subject(:component) { described_class.new(name, options) }

  before do
    allow(Simulacrum).to receive(:configuration) { configuration }
    allow(Capybara).to receive(:current_driver) { driver_name }
    expect(Simulacrum::Renderer).to receive(:new).with(options.url) { renderer }
  end

  describe '#render' do
    subject { component.render }

    before do
      configuration.candidate_filename = 'candidate'
      expect(FileUtils).to receive(:mkdir_p).with('references/MyComponent/MyDriver')
      expect(renderer).to receive(:render) { '/tmp/rendered_component.png' }
      expect(FileUtils).to receive(:mv).with('/tmp/rendered_component.png', 'references/MyComponent/MyDriver/candidate.png')
      expect(renderer).to receive(:cleanup)
    end

    it { is_expected.to eq(true) }

    describe 'when a selector is set the candidate is cropped' do
      let(:capture_selector) { '.widget' }
      let(:images) { double }
      let(:image) { double('Magick::Image') }
      let(:selector_bounds) { [0, 0, 100, 100] }

      before do
        options.capture_selector = capture_selector
        expect(Magick::Image).to receive(:read).with('references/MyComponent/MyDriver/candidate.png') { images }
        expect(images).to receive(:first) { image }
        expect(renderer).to receive(:get_bounds_for_selector).with(capture_selector) { selector_bounds }
        expect(image).to receive(:crop!).with(*selector_bounds)
        expect(image).to receive(:write).with('references/MyComponent/MyDriver/candidate.png')
      end

      it { is_expected.to eq(true) }
    end
  end

  describe '#reference?' do
    let(:reference_filename) { 'reference' }
    subject { component.reference? }

    before do
      configuration.reference_filename = reference_filename
    end

    it { is_expected.to eq(false) }

    context 'when a reference image exists' do
      before do
        expect(File).to receive(:exist?).with('references/MyComponent/MyDriver/reference.png') { true }
      end

      it { is_expected.to eq(true) }
    end
  end

  describe '#candidate?' do
    let(:candidate_filename) { 'candidate' }
    subject { component.candidate? }

    before(:each) do
      configuration.candidate_filename = 'candidate'
    end

    it { is_expected.to eq(false) }

    context 'when a candidate image exists' do
      before(:each) do
        allow(File).to receive(:exist?).with('references/MyComponent/MyDriver/candidate.png') { true }
      end

      it { is_expected.to eq(true) }
    end
  end

  describe '#diff?' do
    let(:diff_filename) { 'diff' }
    subject { component.diff? }

    before(:each) do
      configuration.diff_filename = diff_filename
    end

    it { is_expected.to eq(false) }

    context 'when a diff image exists' do
      before(:each) do
        expect(File).to receive(:exist?).with('references/MyComponent/MyDriver/diff.png') { true }
      end

      it { is_expected.to eq(true) }
    end
  end

  describe '#delta_threshold' do
    subject { component.delta_threshold }

    let(:configuration) { OpenStruct.new delta_threshold: 99 }

    it { is_expected.to eq(99) }

    context 'when the delta_threshold option has been passed in' do
      let(:options) { Struct.new(:url, :delta_threshold).new('http://localhost', 1) }

      it 'uses the option value' do
        is_expected.to eq(1)
      end
    end
  end

  describe '#reference_path' do
    subject { component.reference_path }

    before do
      configuration.reference_filename = 'reference'
    end

    it { is_expected.to eq('references/MyComponent/MyDriver/reference.png') }
  end

  describe '#candidate_path' do
    subject { component.candidate_path }

    before do
      configuration.candidate_filename = 'candidate'
    end

    it { is_expected.to eq('references/MyComponent/MyDriver/candidate.png') }
  end

  describe '#diff_path' do
    subject { component.diff_path }

    before do
      configuration.diff_filename = 'diff'
    end

    it { is_expected.to eq('references/MyComponent/MyDriver/diff.png') }
  end

  describe '#remove_candidate' do
    subject { component.remove_candidate }

    before do
      expect(File).to receive(:exist?) { has_candidate }
    end

    context 'when a candidate exists' do
      let(:has_candidate) { true }

      before do
        expect(FileUtils).to receive(:rm)
      end

      it { is_expected.to be_nil }
    end

    context 'when there is no candidate exists' do
      let(:has_candidate) { false }

      it { is_expected.to be_nil }
    end
  end

  describe '#remove_diff' do
    subject { component.remove_diff }

    before do
      expect(File).to receive(:exist?) { has_diff }
    end

    context 'when a diff exists' do
      let(:has_diff) { true }

      before do
        expect(FileUtils).to receive(:rm)
      end

      it { is_expected.to be_nil }
    end

    context 'when there is no diff exists' do
      let(:has_diff) { false }

      it { is_expected.to be_nil }
    end
  end
end
