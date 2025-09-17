class DeliveryCalculator
  attr_reader :rules

  def initialize(rules)
    @rules = rules.sort_by { |rule| -rule[:threshold] }
  end

  def calculate(subtotal)
    rules.each do |rule|
      return rule[:cost] if subtotal >= rule[:threshold]
    end

    0.0
  end
end