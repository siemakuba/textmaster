load './app.rb'

describe Checkout do
  subject(:checkout) { Checkout.new(pricing_rules) }
  let(:apple) { Product::Apple.new }
  let(:tea) { Product::FruitTea.new }
  let(:coffee) { Product::Coffee.new }

  context 'when no pricing rules are applied' do
    let(:pricing_rules) { nil }
    before {
      checkout.scan(apple)
      checkout.scan(tea)
      checkout.scan(coffee)
    }

    specify {
      expect(checkout.total).to eql 19.34
    }
  end

  context 'when apple pricing rules are applied' do
    let(:pricing_rules) { PricingRule::Apple.new }

    context 'when pricing rule is not applicable' do
      before {
        checkout.scan(apple)
      }

      specify {
        expect(checkout.total).to eql 5.0
      }
    end

    context 'when pricing rule is applicable' do
      before {
        checkout.scan(apple)
        checkout.scan(apple)
        checkout.scan(apple)
      }

      specify {
        expect(checkout.total).to eql 13.5
      }
    end
  end

  context 'when tea pricing rules are applied' do
    let(:pricing_rules) { PricingRule::FruitTea.new }

    context 'when pricing rule is not applicable' do
      before {
        checkout.scan(tea)
      }

      specify {
        expect(checkout.total).to eql 3.11
      }
    end

    context 'when pricing rule is applicable (2 items)' do
      before {
        checkout.scan(tea)
        checkout.scan(tea)
      }

      specify {
        expect(checkout.total).to eql 3.11
      }
    end


    context 'when pricing rule is applicable (3 items)' do
      before {
        checkout.scan(tea)
        checkout.scan(tea)
        checkout.scan(tea)
      }

      specify {
        expect(checkout.total).to eql 6.22
      }
    end
  end
end
