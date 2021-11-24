FactoryBot.define do
  factory :admin do
    email { "boss@teste"}
    password { "123456" }
    password_confirmation { "123456" }
  end
end
