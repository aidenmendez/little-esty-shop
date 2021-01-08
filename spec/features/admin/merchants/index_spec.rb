require 'rails_helper'

RSpec.describe 'As an Admin', type: :feature do
  describe 'When I visit the merchant index' do
    before(:each) do
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
  end
end