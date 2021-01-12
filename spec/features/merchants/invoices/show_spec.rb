require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "When I visit my merchant's invoice show page" do
    before do
      @merchant1 = FactoryBot.create(:merchant)
      @item1 = FactoryBot.create(:item, merchant_id: @merchant1.id)
      @item2 = FactoryBot.create(:item, merchant_id: @merchant1.id)
      @item3 = FactoryBot.create(:item, merchant_id: @merchant1.id)
      @item4 = FactoryBot.create(:item, merchant_id: @merchant1.id)

      @merchant2 = FactoryBot.create(:merchant)
      @item5 = FactoryBot.create(:item, merchant_id: @merchant2.id)
      @item6 = FactoryBot.create(:item, merchant_id: @merchant2.id)

      4.times { FactoryBot.create(:customer) }

      @invoice1 = FactoryBot.create(:invoice, merchant: @merchant1)
      @invoice2 = FactoryBot.create(:invoice, merchant: @merchant2)
      @invoice3 = FactoryBot.create(:invoice, merchant: @merchant2)
      @invoice4 = FactoryBot.create(:invoice, merchant: @merchant1)
      @invoice5 = FactoryBot.create(:invoice, merchant: @merchant1)
      @invoice6 = FactoryBot.create(:invoice, merchant: @merchant2)
      @invoice7 = FactoryBot.create(:invoice, merchant: @merchant1)

      FactoryBot.create(:invoice_item, invoice: @invoice1, item: @item1)
      FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item6)
      FactoryBot.create(:invoice_item, invoice: @invoice2, item: @item5)
      FactoryBot.create(:invoice_item, invoice: @invoice4, item: @item2)
      FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item3)
      FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item6)
      FactoryBot.create(:invoice_item, invoice: @invoice1, item: @item3)
      FactoryBot.create(:invoice_item, invoice: @invoice5, item: @item1)
      FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item3)
    end

    # For this, are we using the merchant/ invoice one-to-many relationship or invoice_items?
    it "Then I see information related to that invoice" do
      visit merchant_invoice_path(@merchant1.id,  @invoice1.id)

      expect(page).to have_content("Invoice-#{@invoice1.id}")
      expect(page).to have_content("ID: #{@invoice1.id}")
      expect(page).to have_content("Status: #{@invoice1.status}")

      expect(page).to have_content("Created: #{@invoice1.created_at.strftime('%A')}, #{@invoice1.created_at.strftime('%B')} #{@invoice1.created_at.day}, #{@invoice1.created_at.year}")
    end

    it "Then I see all of the customer information related to that invoice" do
      visit merchant_invoice_path(@merchant1.id,  @invoice1.id)
      customer = Customer.find(@invoice1.customer_id)
      expect(page).to have_content("Name: #{customer.first_name} #{customer.last_name}")
      expect(page).to have_content("Shipping address: #{customer.shipping_address}")

    end
  end
end