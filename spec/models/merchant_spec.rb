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
    merchant_7 = create(:merchant)

    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    item_3 = create(:item, merchant_id: merchant_3.id)
    item_4 = create(:item, merchant_id: merchant_4.id)
    item_5 = create(:item, merchant_id: merchant_5.id)
    item_6 = create(:item, merchant_id: merchant_6.id)

    customer_1 = create(:customer)

    invoice_1 = create(:invoice, customer: customer_1, merchant: merchant_1)
    invoice_2 = create(:invoice, customer: customer_1, merchant: merchant_2)
    invoice_3 = create(:invoice, customer: customer_1, merchant: merchant_3)
    invoice_4 = create(:invoice, customer: customer_1, merchant: merchant_4)
    invoice_5 = create(:invoice, customer: customer_1, merchant: merchant_5)
    invoice_6 = create(:invoice, customer: customer_1, merchant: merchant_6)
    invoice_7 = create(:invoice, customer: customer_1, merchant: merchant_6)

    transaction_1 = create(:transaction, invoice: invoice_1, result: 1)
    transaction_2 = create(:transaction, invoice: invoice_2, result: 1)
    transaction_3 = create(:transaction, invoice: invoice_3, result: 1)
    transaction_4 = create(:transaction, invoice: invoice_4, result: 1)
    transaction_5 = create(:transaction, invoice: invoice_5, result: 1)
    transaction_6 = create(:transaction, invoice: invoice_6, result: 1)
    transaction_7 = create(:transaction, invoice: invoice_7, result: 0)


    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 10, unit_price: 1)
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, quantity: 10, unit_price: 2)
    invoice_item_3 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, quantity: 10, unit_price: 3)
    invoice_item_4 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_4.id, quantity: 10, unit_price: 4)
    invoice_item_5 = create(:invoice_item, item_id: item_5.id, invoice_id: invoice_5.id, quantity: 10, unit_price: 5)
    invoice_item_6 = create(:invoice_item, item_id: item_6.id, invoice_id: invoice_6.id, quantity: 10, unit_price: 6)
    invoice_item_7 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_7.id, quantity: 10, unit_price: 10)

    expect(Merchant.top_merchants).to eq([merchant_6,merchant_5,merchant_4,merchant_3, merchant_2])
    expect(Merchant.top_merchants[0].total_revenue).to eq(60)
    end
      it "order by merchant status enabled" do

        merchant_1 =create(:merchant, status: 'enabled')
        merchant_2 = create(:merchant, status: 'enabled')
        merchant_3 =create(:merchant, status: 'disabled')
        merchant_4 = create(:merchant, status: 'disabled')

        expect(Merchant.enabled_merchants).to eq([merchant_1, merchant_2])
      end
      it "order by merchant status disabled" do

        merchant_1 =create(:merchant, status: 'enabled')
        merchant_2 = create(:merchant, status: 'enabled')
        merchant_3 =create(:merchant)
        merchant_4 = create(:merchant)

        expect(Merchant.disabled_merchants).to eq([merchant_3, merchant_4])
      end
  end
    
  describe 'instance methods' do 
    it 'Shows best day for each top merchant' do
      merchant_1 = create(:merchant)

      item_1 = create(:item, merchant_id: merchant_1.id)

      customer_1 = create(:customer)

      invoice_1 = create(:invoice, customer: customer_1, merchant: merchant_1, created_at: "2020-01-25 09:54:01")
      invoice_2 = create(:invoice, customer: customer_1, merchant: merchant_1, created_at: "2020-01-26 06:53:07")
      invoice_3 = create(:invoice, customer: customer_1, merchant: merchant_1, created_at: "2020-01-27 05:54:30")

      transaction_1 = create(:transaction, invoice: invoice_1, result: 1)
      transaction_2 = create(:transaction, invoice: invoice_2, result: 1)
      transaction_3 = create(:transaction, invoice: invoice_3, result: 1)
      transaction_4 = create(:transaction, invoice: invoice_1, result: 1)
      transaction_5 = create(:transaction, invoice: invoice_1, result: 1)
      transaction_6 = create(:transaction, invoice: invoice_2, result: 1)
      transaction_7 = create(:transaction, invoice: invoice_3, result: 0)


      invoice_item_6 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 10, unit_price: 6)
      invoice_item_7 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 10, unit_price: 10)

      expect(merchant_1.best_day).to eq(invoice_1.date_time)
    end
  end
end
