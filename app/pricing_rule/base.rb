module PricingRule
  class Base
    def apply!(items)
      @items = items
      rule_applies? ? apply_rule : items
    end

    private
    attr_reader :items

    def apply_rule
      items - applicable_items + discounted_items
    end
  end
end
