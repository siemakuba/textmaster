require_relative '../app/checkout_item.rb'

describe CheckoutItem do
  let(:product) { double(price: 2.11) }
  subject { described_class.new(product) }

  describe '#price' do
    specify 'without discount' do
      expect(subject.price).to eql 2.11
    end

    context 'with discount' do
      before {
        subject.discount_to(0.55)
      }
      specify {
        expect(subject.price).to eql 0.55
      }
    end
  end
end
