require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should belong_to :customer}
    it { should belong_to :merchant}
  end

  describe 'validations' do
    it { should validate_presence_of :status}
  end

  describe 'class methods' do
    it "shows incomplete invoices" do
      Invoice.destroy_all

    merchant = Merchant.create!(name: 'House of thingys')
    customer_1 = Customer.create!(first_name: 'John', last_name: 'Doe')
    invoice_1 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant.id, status: 0)
    invoice_2 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant.id, status: 1)
    invoice_3 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant.id, status: 2)
  
    expect(Invoice.incomplete_invoices).to eq([invoice_1.id])
    end
  end
  describe "instance methods" do
    it "formats datetime" do
    merchant = Merchant.create!(name: 'House of thingys')
    customer = Customer.create!(first_name: 'John', last_name: 'Doe')
    invoice_4 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: 0, created_at: 2012-03-25)

    expect(invoice_1.date_time).to eq("#{invoice_1.created_at.strftime('%A')}, #{invoice_1.created_at.strftime('%B')} #{invoice_1.created_at.day}, #{invoice_1.created_at.year}")

    end
  end
    it 'Sums Revenue' do
      merchant = Merchant.create!(name: 'House of thingys')
      customer = Customer.create!(first_name: 'Hooman', last_name:"Mcbuythings", shipping_address: "Bouldah!")
      invoice_5 = Invoice.create!(customer_id: customer.id, merchant_id: merchant.id, status: 0, created_at: 2012-03-25)
      item_1 = Item.create!(name: 'doo hickey', description: 'more fun than a hootenany!', unit_price: 23, merchant_id: merchant.id)
      item_2 = Item.create!(name: 'doo hickey pro', description: 'gooolllld', unit_price: 40, merchant_id: merchant.id)
      invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_5.id, quantity: 10, unit_price: item_1.unit_price, status: 0)
      invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_5.id, quantity: 1, unit_price: item_2.unit_price, status: 1)
    
    expect(invoice_5.total_revenue).to eq(270)
    end
end
