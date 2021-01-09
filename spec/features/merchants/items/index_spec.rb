require "rails_helper"

RSpec.describe "As a merchant" do
  describe "When I visit my merchant items index page" do
    before do
      @merchant = FactoryBot.create(:merchant)
      @item1 = FactoryBot.create(:item, merchant_id: @merchant.id)
      @item2 = FactoryBot.create(:item, merchant_id: @merchant.id)
      @item3 = FactoryBot.create(:item, merchant_id: @merchant.id)
      @item4 = FactoryBot.create(:item, merchant_id: @merchant.id)

      @merchant2 = FactoryBot.create(:merchant)
      @item5 = FactoryBot.create(:item, merchant_id: @merchant2.id)
      @item6 = FactoryBot.create(:item, merchant_id: @merchant2.id)
    end

    it "I see a list of the names of all of my items and none from other merchants" do
      visit "merchant/#{@merchant.id}/items"

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item3.name)
      expect(page).to have_content(@item4.name)

      expect(page).not_to have_content(@item5.name)
      expect(page).not_to have_content(@item6.name)      
    end
  end
end