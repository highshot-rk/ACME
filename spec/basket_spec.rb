# frozen_string_literal: true

require_relative '../lib/product'
require_relative '../lib/delivery_calculator'
require_relative '../lib/offer'
require_relative '../lib/basket'

RSpec.describe Basket do
  let(:product_catalog) do
    [
      Product.new('R01', 'Red Widget', 32.95),
      Product.new('G01', 'Green Widget', 24.95),
      Product.new('B01', 'Blue Widget', 7.95)
    ]
  end

  let(:delivery_rules) do
    [
      { threshold: 90.0, cost: 0.0 },
      { threshold: 50.0, cost: 2.95 },
      { threshold: 0.0, cost: 4.95 }
    ]
  end

  let(:delivery_calculator) { DeliveryCalculator.new(delivery_rules) }
  let(:offers) { [BuyOneGetSecondHalfPriceOffer.new('R01')] }

  subject { Basket.new(product_catalog, delivery_calculator, offers) }

  describe '#total' do
    context 'with B01, G01' do
      it 'returns the expected total' do
        subject.add('B01')
        subject.add('G01')
        expect(subject.total).to eq(37.85) # 7.95 + 24.95 + 4.95 delivery
      end
    end

    context 'with R01, R01' do
      it 'returns the expected total with offer applied' do
        subject.add('R01')
        subject.add('R01')
        expect(subject.total).to eq(54.37) # 32.95 + (32.95/2) + 4.95 delivery
      end
    end

    context 'with R01, G01' do
      it 'returns the expected total' do
        subject.add('R01')
        subject.add('G01')
        expect(subject.total).to eq(60.85) # 32.95 + 24.95 + 2.95 delivery
      end
    end

    context 'with B01, B01, R01, R01, R01' do
      it 'returns the expected total with offer applied' do
        subject.add('B01')
        subject.add('B01')
        subject.add('R01')
        subject.add('R01')
        subject.add('R01')
        # 7.95 + 7.95 + 32.95 + 32.95 + 32.95 - 32.95/2 - 32.95/2 + 0 delivery
        expect(subject.total).to eq(98.27)
      end
    end
  end
end