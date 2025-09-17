class Basket
  attr_reader :product_catalog, :delivery_calculator, :offers, :items

  def initialize(product_catalog, delivery_calculator, offers = [])
    @product_catalog = product_catalog
    @delivery_calculator = delivery_calculator
    @offers = offers
    @items = []
  end

  def add(product_code)
    @items << product_code
  end

  def total
    subtotal = calculate_subtotal
    discount = calculate_discount
    delivery_charge = delivery_calculator.calculate(subtotal - discount)

    # Format to 2 decimal
    ((subtotal - discount + delivery_charge) * 100).floor / 100.to_f
  end

  private

  def calculate_subtotal
    @items.sum do |code|
      product = find_product(code)
      product ? product.price : 0
    end
  end

  def calculate_discount
    @offers.sum do |offer|
      offer.apply(@items, @product_catalog)
    end
  end

  def find_product(code)
    @product_catalog.find { |product| product.code == code }
  end
end