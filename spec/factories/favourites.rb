FactoryBot.define do
  factory :favourite do
    user { association :user }
    product { association :product }
  end
end
