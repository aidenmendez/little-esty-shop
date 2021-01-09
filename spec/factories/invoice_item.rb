FactoryBot.define do
  factory :invoice_item do
    invoice_id { Invoice.all.sample.id }
    item_id { Item.all.sample.id }
    quantity { (1..10).to_a.sample }
    unit_price { Faker::Commerce.price(5.00..50.00) }
    status { [0,1,2].sample }
  end
end