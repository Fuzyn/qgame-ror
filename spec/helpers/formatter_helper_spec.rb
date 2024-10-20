require 'rails_helper'

RSpec.describe FormatterHelper, type: :helper do
  describe '#number_formatter' do
    it 'formats a small number without thousands separator' do
      expect(helper.number_formatter(123)).to eq('123')
    end

    it 'formats a number with one thousands separator' do
      expect(helper.number_formatter(1234)).to eq('1.234')
    end

    it 'formats a number with two thousands separators' do
      expect(helper.number_formatter(1234567)).to eq('1.234.567')
    end

    it 'formats a number with three thousands separators' do
      expect(helper.number_formatter(1234567890)).to eq('1.234.567.890')
    end

    it 'formats a large number with multiple thousands separators' do
      expect(helper.number_formatter(9876543210987)).to eq('9.876.543.210.987')
    end

    it 'formats a number with an exact thousands boundary' do
      expect(helper.number_formatter(1000)).to eq('1.000')
    end

    it 'handles zero' do
      expect(helper.number_formatter(0)).to eq('0')
    end

    it 'handles large zero-padded numbers' do
      expect(helper.number_formatter(1000000)).to eq('1.000.000')
    end
  end
end
