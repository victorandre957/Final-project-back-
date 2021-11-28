require 'rails_helper'

RSpec.describe Type, type: :model do
  describe 'factory' do
    context 'when using standard factory' do
      it { expect(build(:type)).to be_valid }
    end
  end

  describe 'validations' do
    context 'when type does not have a name' do
      it { expect(build(:type, name: nil)).not_to be_valid }
    end

    context 'when 2 types have the same name' do
      before do
        create(:type)
      end
      
      it { expect(build(:type)).not_to be_valid }
    end
  end
end
