require 'rails_helper'

RSpec.describe 'As an Admin', type: :feature do
  describe 'When I visit the admin merchant index' do
    before(:each) do
      Merchant.destroy_all
      @merchant_1 = Merchant.create!(name: 'House of thingys')
      @merchant_2 = Merchant.create!(name: 'House of mirros')
      @merchant_3 = Merchant.create!(name: 'House of horrors')
    end

    it 'I see the name of each merchant' do

      visit admin_merchants_path

      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_3.name)
    end

    it 'I click on the name of a merchant and am taken to their show page' do

      visit admin_merchants_path

      click_on @merchant_1.name

      expect(current_path).to eq("/admin/merchants/#{@merchant_1.id}")
    end
    it 'Has a button to create a merchant, when I check on the link Im taking to a form' do
      visit admin_merchants_path

      expect(page).to have_button("Create Merchant")

      click_on "Create Merchant"

      expect(current_path).to eq(new_admin_merchant_path)
      expect(page).to have_field(:name)
    end
    it 'When I fill out the form and click submit Im taken back to index and the merchant is there' do

      visit admin_merchants_path

      click_on "Create Merchant"

      fill_in :name, with: "House of Fun"

      click_on "Submit"

      expect(current_path).to eq(admin_merchants_path)
      expect(page).to have_content("House of Fun")
    end
    it 'shows top 5 merchants by revenue' do
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

    visit admin_merchants_path
    expect(page).to have_content("#{merchant_6.name} - $60 revenue")
    expect(page).to have_content("#{merchant_5.name} - $50 revenue")
    expect(page).to have_content("#{merchant_4.name} - $40 revenue")
    expect(page).to have_content("#{merchant_3.name} - $30 revenue")
    expect(page).to have_content("#{merchant_2.name} - $20 revenue")
    end
    it 'Has a button to disable and enable merchants' do
      merchant_1 =create(:merchant, status: 'enabled')
      merchant_2 = create(:merchant, status: 'enabled')
      merchant_3 =create(:merchant)
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


      visit admin_merchants_path

      expect(page).to have_button('Enable Merchant')
      expect(page).to have_button('Disable Merchant')

      first(".merchants").click_button('Disable Merchant')

      merchant_1.reload
      merchant_2.reload
      merchant_3.reload
      merchant_4.reload

      expect(current_path).to eq(admin_merchants_path)
      expect(merchant_1.status).to eq('enabled')
    end
  end
end
