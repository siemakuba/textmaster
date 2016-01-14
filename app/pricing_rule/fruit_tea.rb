module PricingRule
  class FruitTea < Base
    DISCOUNTED_PRICE = 0.0

    private

    def discounted_items
      applicable_items.map.with_index do |item, idx|
        item.discount_to(DISCOUNTED_PRICE) if idx.odd?
        item
      end
    end

    def applicable_items
      @applicable_items ||= items.select { |item| item.product?(Product::FruitTea) }
    end

    def rule_applies?
      applicable_items.count > 1
    end
  end
end
