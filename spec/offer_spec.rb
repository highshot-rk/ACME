# frozen_string_literal: true

require_relative '../lib/product'
require_relative '../lib/offer'

RSpec.describe BuyOneGetSecondHalfPriceOffer do
  let(:product_catalog) do
    [
      Product.new('R01', 'Red Widget', 32.95),
      Product.new('G01', 'Green Widget', 24.95),
      Product.new('B01', 'Blue Widget', 7.95)
    ]
  end

  subject { BuyOneGetSecondHalfPriceOffer.new('R01') }

  describe '#apply' do
    it 'returns 0 discount when no items match offer product' do
      items = ['B01', 'G01']
      expect(subject.apply(items, product_catalog)).to eq(0)
    end

    it 'returns 0 discount for a single qualifying item' do
      items = ['R01']
      expect(subject.apply(items, product_catalog)).to eq(0)
    end

    it 'returns half price discount for two qualifying items' do
      items = ['R01', 'R01']
      expect(subject.apply(items, product_catalog)).to eq(32.95 / 2)
    end

    it 'returns multiple half price discounts for four qualifying items' do
      items = ['R01', 'R01', 'R01', 'R01']
      expect(subject.apply(items, product_catalog)).to eq(32.95)
    end

    it 'handles odd number of qualifying items correctly' do
      items = ['R01', 'R01', 'R01']
      expect(subject.apply(items, product_catalog)).to eq(32.95 / 2)
    end

    it 'returns correct discount with mixed items' do
      items = ['B01', 'R01', 'G01', 'R01', 'B01', 'R01', 'R01']
      expect(subject.apply(items, product_catalog)).to eq(32.95)
    end
  end
end