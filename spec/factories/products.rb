FactoryBot.define do
  factory :product do
    name { "product" }
    type { association :type }
    price { 1.5 }
    quantity { "500g" }
    description { "description" }
  end
end
