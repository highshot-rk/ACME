require_relative 'lib/product'
require_relative 'lib/delivery_calculator'
require_relative 'lib/offer'
require_relative 'lib/basket'

class AcmeBasket
  def self.setup
    # Create product catalog
    product_catalog = [
      Product.new('R01', 'Red Widget', 32.95),
      Product.new('G01', 'Green Widget', 24.95),
      Product.new('B01', 'Blue Widget', 7.95)
    ]

    # Set up delivery charge rules
    delivery_rules = [
      { threshold: 90.0, cost: 0.0 },
      { threshold: 50.0, cost: 2.95 },
      { threshold: 0.0, cost: 4.95 }
    ]
    delivery_calculator = DeliveryCalculator.new(delivery_rules)

    # Set up special offers
    offers = [BuyOneGetSecondHalfPriceOffer.new('R01')]

    # Create and return the basket
    Basket.new(product_catalog, delivery_calculator, offers)
  end

  def self.run_scenarios
    baskets = [
      ['B01', 'G01'],
      ['R01', 'R01'],
      ['R01', 'G01'],
      ['B01', 'B01', 'R01', 'R01', 'R01']
    ]

    baskets.each do |items|
      basket = setup
      items.each { |code| basket.add(code) }
      puts "Products: #{items.join(', ')} | Total: $#{basket.total}"
    end
  end
end

AcmeBasket.run_scenarios