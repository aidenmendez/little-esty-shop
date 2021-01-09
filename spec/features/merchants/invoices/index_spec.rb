require 'rails_helper'

RSpec.describe "As a merchant" do
  describe "when I visit my merchant's invoices index" do
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
    it "I see all of the invoices that include at least one of my merchant's items and for each invoice I see its id" do
      visit merchant_invoices_path(@merchant1.id)

      expect(page).to have_content("Invoice-#{@invoice1.id}")
      expect(page).to have_content("Invoice-#{@invoice4.id}")
      expect(page).to have_content("Invoice-#{@invoice5.id}")
      expect(page).to have_content("Invoice-#{@invoice7.id}")

      expect(page).not_to have_content("Invoice-#{@invoice2.id}")
      expect(page).not_to have_content("Invoice-#{@invoice3.id}")
      expect(page).not_to have_content("Invoice-#{@invoice6.id}")
    end

    it "and each id links to the merchant invoice show page" do
      visit merchant_invoices_path(@merchant1.id)

      click_link("Invoice-#{@invoice1.id}")
      expect(current_path).to eq(merchant_invoice_path(@merchant1.id, @invoice1.id))
    end
  end
end