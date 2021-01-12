FactoryBot.define do 
  factory :customer do
    first_name        { Faker::Name.unique.first_name }
    last_name         { Faker::Name.unique.last_name }
    shipping_address  { Faker::Address.full_address }
  end
end