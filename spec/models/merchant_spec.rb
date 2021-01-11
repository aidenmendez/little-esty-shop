require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :invoices}
    it { should have_many :items}
  end
  describe 'validations' do
    it { should validate_presence_of :name}
  end

  describe 'class methods' do
    it 'should return top 5 merchants by revenue' do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)
    merchant_4 = create(:merchant)
    merchant_5 = create(:merchant)
    merchant_6 = create(:merchant)

    customer_1 = create(:customer)

    invoice_1 = create(:invoice, customer: customer_1, merchant: merchant_1)
    invoice_2 = create(:invoice, customer: customer_1, merchant: merchant_2)
    invoice_3 = create(:invoice, customer: customer_1, merchant: merchant_3)
    invoice_4 = create(:invoice, customer: customer_1, merchant: merchant_4)
    invoice_5 = create(:invoice, customer: customer_1, merchant: merchant_5)
    invoice_6 = create(:invoice, customer: customer_1, merchant: merchant_6)
    invoice_7 = create(:invoice, customer: customer_1, merchant: merchant_1)

    item_1 = create(:item, merchant_id: merchant_1)
    item_2 = create(:item, merchant_id: merchant_2)
    item_3 = create(:item, merchant_id: merchant_3)
    item_4 = create(:item, merchant_id: merchant_4)
    item_5 = create(:item, merchant_id: merchant_5)
    item_6 = create(:item, merchant_id: merchant_6)

    invoice_item_1 = create(:invoice_item, item_id: item_1, invoice_id: invoice_1.id, quantity: 10, unit_price: 1)
    invoice_item_2 = create(:invoice_item, item_id: item_2, invoice_id: invoice_2.id, quantity: 10, unit_price: 2)
    invoice_item_3 = create(:invoice_item, item_id: item_3, invoice_id: invoice_3.id, quantity: 10, unit_price: 3)
    invoice_item_4 = create(:invoice_item, item_id: item_4, invoice_id: invoice_4.id, quantity: 10, unit_price: 4)
    invoice_item_5 = create(:invoice_item, item_id: item_5, invoice_id: invoice_5.id, quantity: 10, unit_price: 5)
    invoice_item_6 = create(:invoice_item, item_id: item_6, invoice_id: invoice_6.id, quantity: 10, unit_price: 6)
    invoice_item_7 = create(:invoice_item, item_id: item_1, invoice_id: invoice_7.id, quantity: 10, unit_price: 10)

    expect(Merchant.top_customers).to eq([merchant_1,merchant_2,merchant_3,merchant_4,merchant_5])
    end
  end
end
