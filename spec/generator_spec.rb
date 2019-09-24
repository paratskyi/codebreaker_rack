require 'spec_helper'

RSpec.describe Generator do
  describe '#generate' do
    context 'when generate elements' do
      it 'returns danger mark' do
        expect(described_class.danger_mark).to include('btn-danger', 'x')
      end
      it 'returns success mark' do
        expect(described_class.success_mark).to include('btn-success', '+')
      end
      it 'returns primary mark' do
        expect(described_class.primary_mark).to include('btn-primary', '-')
      end
      it 'returns hint span with passed hint' do
        expect(described_class.hint_span(1)).to include('1')
      end
      it 'returns correct guess marks' do
        allow(Getter).to receive(:result).and_return('+--')
        expect(described_class.guess_marks).to include('btn-success', 'btn-primary', 'btn-primary', 'btn-danger')
      end
    end
  end
end
