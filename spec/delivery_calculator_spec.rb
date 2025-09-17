# frozen_string_literal: true

require_relative '../lib/delivery_calculator'

RSpec.describe DeliveryCalculator do
  let(:delivery_rules) do
    [
      { threshold: 90.0, cost: 0.0 },
      { threshold: 50.0, cost: 2.95 },
      { threshold: 0.0, cost: 4.95 }
    ]
  end

  subject { DeliveryCalculator.new(delivery_rules) }

  describe '#calculate' do
    it 'returns 4.95 for orders under $50' do
      expect(subject.calculate(49.99)).to eq(4.95)
      expect(subject.calculate(0)).to eq(4.95)
      expect(subject.calculate(32.95)).to eq(4.95)
    end

    it 'returns 2.95 for orders $50 or more but under $90' do
      expect(subject.calculate(50.0)).to eq(2.95)
      expect(subject.calculate(75.5)).to eq(2.95)
      expect(subject.calculate(89.99)).to eq(2.95)
    end

    it 'returns 0.0 for orders $90 or more' do
      expect(subject.calculate(90.0)).to eq(0.0)
      expect(subject.calculate(100.0)).to eq(0.0)
      expect(subject.calculate(999.99)).to eq(0.0)
    end
  end
end