module PricingRule
  class Apple < Base
    DISCOUNTED_PRICE = 4.5

    private

    def discounted_items
      applicable_items.map do |item|
        item.discount_to(DISCOUNTED_PRICE)
        item
      end
    end

    def applicable_items
      @applicable_items ||= items.select { |item| item.product?(Product::Apple) }
    end

    def rule_applies?
      applicable_items.count >= 3
    end
  end
end
