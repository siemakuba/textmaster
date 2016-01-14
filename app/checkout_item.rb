class CheckoutItem
  def initialize(item)
    @item = item
  end

  def price
    discounted_price || item.price
  end

  def discount_to(discounted_price)
    self.discounted_price = discounted_price
  end

  def product?(klass)
    item.is_a?(klass)
  end

  private
  attr_reader :item
  attr_accessor :discounted_price
end
