class Checkout
  def initialize(rules)
    @rules = Array(rules)
    @items = []
  end

  def scan(product)
    items << CheckoutItem.new(product)
  end

  def total
    calculate_discount!
    items.inject(0) { |sum, item| sum + item.price }
  end

  private
  attr_reader :rules
  attr_accessor :items

  def calculate_discount!
    rules.each do |rule|
      self.items = rule.apply!(items)
    end
  end
end
