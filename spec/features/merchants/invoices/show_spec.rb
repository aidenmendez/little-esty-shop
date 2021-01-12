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
      @customer5 = FactoryBot.create(:customer)
      
      @invoice1 = FactoryBot.create(:invoice, merchant: @merchant1)
      @invoice2 = FactoryBot.create(:invoice, merchant: @merchant2)
      @invoice3 = FactoryBot.create(:invoice, merchant: @merchant2)
      @invoice4 = FactoryBot.create(:invoice, merchant: @merchant1)
      @invoice5 = FactoryBot.create(:invoice, merchant: @merchant1)
      @invoice6 = FactoryBot.create(:invoice, merchant: @merchant2)
      @invoice7 = FactoryBot.create(:invoice, merchant: @merchant1)
      @invoice8 = FactoryBot.create(:invoice, merchant_id: @merchant1.id, customer_id: @customer5.id)
      
      @invoice_item1 = FactoryBot.create(:invoice_item, invoice: @invoice1, item: @item1)
      @invoice_item2 = FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item6)
      @invoice_item3 = FactoryBot.create(:invoice_item, invoice: @invoice2, item: @item5)
      @invoice_item4 = FactoryBot.create(:invoice_item, invoice: @invoice4, item: @item2)
      @invoice_item5 = FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item3)
      @invoice_item6 = FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item6)
      @invoice_item7 = FactoryBot.create(:invoice_item, invoice: @invoice1, item: @item3)
      @invoice_item8 = FactoryBot.create(:invoice_item, invoice: @invoice5, item: @item1)
      @invoice_item9 = FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item3)
      @invoice_item10 = FactoryBot.create(:invoice_item, invoice: @invoice8, item: @item3)
      @invoice_item11 = FactoryBot.create(:invoice_item, invoice: @invoice8, item: @item4)
      
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
    it "then I see all of my items on the invoice and the items' details" do
      visit merchant_invoice_path(@merchant1.id,  @invoice8.id)

      within("#item-section-#{@item3.id}") do
        expect(page).to have_content("Name: #{@item3.name}")
        expect(page).to have_content("Quantity: #{@invoice_item10.quantity}")
        expect(page).to have_content("Price: $#{@invoice_item10.unit_price}")
        expect(page).to have_content("Status: #{@invoice_item10.status}")
      end

      within("#item-section-#{@item4.id}") do
        expect(page).to have_content("Name: #{@item4.name}")
        expect(page).to have_content("Quantity: #{@invoice_item11.quantity}")
        expect(page).to have_content("Price: $#{@invoice_item11.unit_price}")
        expect(page).to have_content("Status: #{@invoice_item11.status}")
      end
    end

    it "I do not see any information related to Items for other merchants" do
      visit merchant_invoice_path(@merchant1.id,  @invoice8.id)

      expect(page).not_to have_content(@item5.name)
      expect(page).not_to have_content(@item6.name)
      expect(page).not_to have_content(@merchant2.name)
    end
  end
end