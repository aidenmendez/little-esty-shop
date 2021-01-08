require 'rails_helper'

RSpec.describe "as a merchant" do
  describe "when I visit the merchant dashboard" do
    before(:each) do
      @merchant = Merchant.create!(name: "Buy more stuff")
      @merchant = Merchant.create!(name: 'House of thingys')
      @smith = Customer.create!(first_name: 'Smith', last_name:"John")
      @doe = Customer.create!(first_name: 'Smith', last_name:"John")
      @doe = Customer.create!(first_name: 'Smith', last_name:"John")
      @doe = Customer.create!(first_name: 'Smith', last_name:"John")
      @doe = Customer.create!(first_name: 'Smith', last_name:"John")
      @doe = Customer.create!(first_name: 'Smith', last_name:"John")
      @doe = Customer.create!(first_name: 'Smith', last_name:"John")
      @invoice_1 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 0, created_at: 2012-03-25)
      @invoice_2 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 0)
      @invoice_3 = Invoice.create!(customer_id: @customer.id, merchant_id: @merchant.id, status: 1)

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

    it "I see the my merchant's top five customers and their respective number of successful transactions with my merchant" do
      # expect(page).to have_content()
    end
  end
end
