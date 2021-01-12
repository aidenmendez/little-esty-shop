FactoryBot.define do
  factory :transaction do
    invoice_id                  { Invoice.all.sample.id }
    credit_card_number          { Faker::Business.credit_card_number }
    credit_card_expiration_date { Faker::Business.credit_card_expiry_date.to_s}
    result                      { [0, 1].sample }
  end
end