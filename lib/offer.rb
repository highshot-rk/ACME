class Offer
  def apply(items, product_catalog)
    raise NotImplementedError, 'Subclasses must implement apply method'
  end
end

# Buy one, get second half price offer
class BuyOneGetSecondHalfPriceOffer < Offer
  attr_reader :product_code

  def initialize(product_code)
    @product_code = product_code
  end

  def apply(items, product_catalog)
    # Count the occurrences of the target product
    applicable_items = items.select { |code| code == product_code }
    discount_count = applicable_items.size / 2

    # Calculate the discount (half price for every second item)
    if discount_count > 0
      product = product_catalog.find { |product| product.code == product_code }
      return discount_count * (product.price / 2.0) if product
    end

    0
  end
end

# Add other offers here