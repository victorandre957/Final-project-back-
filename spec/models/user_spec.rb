require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factory' do
    context 'when using standard factory' do
      it { expect(build(:user)).to be_valid }
    end
  end

  describe 'validations' do
    context 'when user does not have an email' do
      it { expect(build(:user, email: nil)).not_to be_valid }
    end

    context 'when user does not have a name' do
      it { expect(build(:user, name: nil)).not_to be_valid }
    end

  end
end
