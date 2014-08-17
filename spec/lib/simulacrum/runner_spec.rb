# encoding: UTF-8

require 'simulacrum/runner'

describe Simulacrum::Runner do
  describe '.run' do
    let(:runner_options) { double(runner: runner) }

    before do
      expect(Simulacrum).to receive(:runner_options) { runner_options }
    end

    context 'with the default runner option' do
      let(:runner) { nil }

      it 'uses the default runner option' do
        expect(Simulacrum::Runner::Base).to receive(:new)
        described_class.run
      end
    end

    context 'BrowserStack runner option' do
      let(:runner) { :browserstack }

      it 'uses the BrowserStack runner' do
        pending
        expect(Simulacrum::Runner::BrowserstackRunner).to receive(:new)
        described_class.run
      end
    end
  end
end
