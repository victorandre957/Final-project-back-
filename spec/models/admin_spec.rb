require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'factory' do
    context 'when using standard factory' do
      it { expect(build(:admin)).to be_valid }
    end
  end

  describe 'validations' do
    context 'when admin does not have an email' do
      it { expect(build(:admin, email: nil)).not_to be_valid }
    end

  end
end
