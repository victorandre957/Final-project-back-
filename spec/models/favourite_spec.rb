require 'rails_helper'

RSpec.describe Favourite, type: :model do
  describe 'factory' do
    context 'when using standard factory' do
      it { expect(build(:favourite)).to be_valid }
    end
  end

  describe 'validations' do
    context 'when favourite does not have a user' do
      it { expect(build(:favourite, user: nil)).not_to be_valid}
    end

    context 'when favourite does not have a product' do
      it { expect(build(:favourite, product: nil)).not_to be_valid}
    end
  end
end
