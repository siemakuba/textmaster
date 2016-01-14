load './app.rb'

describe 'example use case' do
  subject(:checkout) { Checkout.new(pricing_rules) }
  let(:pricing_rules) { [PricingRule::Apple.new, PricingRule::FruitTea.new] }
  let(:apple)   { Product::Apple.new }
  let(:tea)     { Product::FruitTea.new }
  let(:coffee)  { Product::Coffee.new }

  context 'example 1: FR1, AP1, FR1, CF1' do
    before {
      checkout.scan(tea)
      checkout.scan(apple)
      checkout.scan(tea)
      checkout.scan(coffee)
    }

    specify 'not expecting invalid suggested value' do
      expect(checkout.total).to_not eql 22.25
    end

    specify 'expecting proper value' do
      expect(checkout.total).to eql 19.34
    end
  end

  context 'example 2: FR1, FR1' do
    before {
      checkout.scan(tea)
      checkout.scan(tea)
    }

    specify {
      expect(checkout.total).to eql 3.11
    }
  end

  context 'example 3: AP1, AP1, FR1, AP1' do
    before {
      checkout.scan(apple)
      checkout.scan(apple)
      checkout.scan(tea)
      checkout.scan(apple)
    }

    specify {
      expect(checkout.total).to eql 16.61
    }
  end
end
