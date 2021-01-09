require 'rails_helper'

RSpec.describe "as a merchant" do
  describe "when I visit the merchant dashboard" do
    before do
      # create one merchant
      @merchant = FactoryBot.create(:merchant)
      
  
      # top 5 customers: 6, 3, 4, 5, 2
      @customer1 = FactoryBot.create(:customer)
      2.times do
        @invoice = FactoryBot.create(:invoice, merchant_id: @merchant.id, customer_id: @customer1.id, status: 1)
        @transaction = FactoryBot.create(:transaction, invoice_id: @invoice.id, result: 1)
      end      
    
      @customer2 = FactoryBot.create(:customer)
      4.times do
        @invoice = FactoryBot.create(:invoice, merchant_id: @merchant.id, customer_id: @customer2.id, status: 1)
        @transaction = FactoryBot.create(:transaction, invoice_id: @invoice.id, result: 1)
      end
      
      
      @customer3 = FactoryBot.create(:customer)
      10.times do
        @invoice = FactoryBot.create(:invoice, merchant_id: @merchant.id, customer_id: @customer3.id, status: 1)
        @transaction = FactoryBot.create(:transaction, invoice_id: @invoice.id, result: 1)
      end
      
      
      @customer4 = FactoryBot.create(:customer)
      7.times do
        @invoice = FactoryBot.create(:invoice, merchant_id: @merchant.id, customer_id: @customer4.id, status: 1)
        @transaction = FactoryBot.create(:transaction, invoice_id: @invoice.id, result: 1)
      end
      
      @customer5 = FactoryBot.create(:customer)
      6.times do
        @invoice = FactoryBot.create(:invoice, merchant_id: @merchant.id, customer_id: @customer5.id, status: 1)
        @transaction = FactoryBot.create(:transaction, invoice_id: @invoice.id, result: 1)
      end
      
      
      @customer6 = FactoryBot.create(:customer)
      12.times do
        @invoice = FactoryBot.create(:invoice, merchant_id: @merchant.id, customer_id: @customer6.id, status: 1)
        @transaction = FactoryBot.create(:transaction, invoice_id: @invoice.id, result: 1) 
      end
    end

    it "Then I see the name of my merchant" do
      visit merchant_dashboard_index_path(@merchant.id)

      expect(page).to have_content("#{@merchant.name}")
    end

    it "dashboard links to my merchant items index" do
      visit merchant_dashboard_index_path(@merchant.id)

      expect(page).to have_link("Items Index")

      click_link("Items Index")

      expect(current_path).to eq(merchant_items_path(@merchant.id))
    end

    it "dashboard links to my merchant invoices index" do
      visit merchant_dashboard_index_path(@merchant.id)

      expect(page).to have_link("Invoices Index")

      click_link("Invoices Index")

      expect(current_path).to eq("/merchants/#{@merchant.id}/invoices")
    end

    # User story Merchant Favorite Customer
    # it "I see the my merchant's top five customers and their respective number of successful transactions with my merchant" do
    #   visit merchant_dashboard_index_path(@merchant.id)

    #   expect(page).to have_content("Top Customers")
    #   expect(page).to have_content(@customer6.name)
    #   expect(page).to have_content(@customer3.name)
    #   expect(page).to have_content(@customer4.name)
    #   expect(page).to have_content(@customer5.name)
    #   expect(page).not_to have_content(@customer1.name)
    # end
  end
end
