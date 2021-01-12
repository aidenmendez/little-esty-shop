FactoryBot.define do
  factory :item do
    merchant_id { Merchant.all.sample.id }
    name        { Faker::Hipster.words.join(' ') }
    description { Faker::Lorem.words(number: 8).join(" ") }
    unit_price  { Faker::Commerce.price }
  end
end
