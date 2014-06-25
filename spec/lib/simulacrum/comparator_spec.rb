# encoding: UTF-8
require 'spec_helper'
require 'ostruct'
require 'simulacrum/comparator'

describe Simulacrum::Comparator do
  let(:reference_path) { '/reference_path' }
  let(:candidate_path) { '/candidate_path' }
  let(:diff_path) { '/diff_path' }
  let(:delta_threshold) { 0 }
  let(:component) { double(reference_path: reference_path,
                           candidate_path: candidate_path,
                           diff_path: diff_path,
                           delta_threshold: delta_threshold) }

  describe '#initialize' do
    subject { described_class.new(component) }

    before do
      expect(component).to receive(:render)
    end
  end

  describe '#test' do
    subject { described_class.new(component).test }

    before do
      expect(component).to receive(:render)
      expect(component).to receive(:reference?) { reference }
    end

    describe 'a reference already exists' do
      let(:reference) { true }

      before do
        expect(Simulacrum::RMagicDiff).to receive(:new).with(reference_path, candidate_path) { diff }
      end

      context 'there is a difference between the candidate and the reference' do
        let(:diff) { double(delta: 1) }

        before do
          expect(diff).to receive(:save).with(diff_path)
        end

        it { is_expected.to eq false }
      end

      context 'the reference and the candidate are identical' do
        let(:diff) { double(delta: 0) }

        before do
          expect(component).to receive(:remove_candidate)
          expect(component).to receive(:remove_diff)
        end

        it { is_expected.to eq true }
      end

      describe 'component delta threshold' do
        it 'should use the component delta threshold to perform to determine if the test passes' do
          pending
        end
      end
    end

    describe 'there is no reference' do
      let(:reference) { false }

      it { is_expected.to be_nil }
    end
  end
end
