require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'factory' do
    context 'when using standard factory' do
      it { expect(build(:product)).to be_valid }
    end
  end

  describe 'validations' do
    context 'when product does not have a name' do
      it { expect(build(:product, name: nil)).not_to be_valid }
    end

    context 'when 2 products have the same name' do
      before do
        create(:product)
      end
      
      it { expect(build(:product)).not_to be_valid }
    end

    context 'when product does not have a price' do
      it { expect(build(:product, price: nil)).not_to be_valid }
    end

    context 'when product does not have a quantity' do
      it { expect(build(:product, quantity: nil)).not_to be_valid }
    end

    context 'when product does not have a description' do
      it { expect(build(:product, description: nil)).not_to be_valid }
    end

    context 'when product has a negative value of price' do
      it { expect(build(:product, price: -1)).not_to be_valid}
    end

    context "when product's price is not a number" do
      it { expect(build(:product, price: "test")).not_to be_valid}
    end

    context "when product does not have a type" do
      it { expect(build(:product, type: nil)).not_to be_valid}
    end
  end

  describe
end
