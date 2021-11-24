FactoryBot.define do
  factory :product do
    name { "product" }
    type { association :type }
    price { 1.5 }
    quantity { 15 }
    description { "description" }
  end
end
