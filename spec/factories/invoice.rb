FactoryBot.define do 
  factory :invoice do
    status      { [0,1,2].sample }
    customer_id { Customer.all.sample.id }
    merchant_id { Merchant.all.sample.id }
  end
end