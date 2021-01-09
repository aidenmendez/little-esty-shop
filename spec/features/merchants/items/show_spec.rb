require "rails_helper"

RSpec.describe "As a merchant" do
  describe "When I visit my merchant items index page" do
    before do
      @merchant1 = FactoryBot.create(:merchant)
      @item1 = FactoryBot.create(:item, merchant_id: @merchant1.id)
      @item2 = FactoryBot.create(:item, merchant_id: @merchant1.id)
      @item3 = FactoryBot.create(:item, merchant_id: @merchant1.id)
      @item4 = FactoryBot.create(:item, merchant_id: @merchant1.id)

      @merchant2 = FactoryBot.create(:merchant)
      @item5 = FactoryBot.create(:item, merchant_id: @merchant2.id)
      @item6 = FactoryBot.create(:item, merchant_id: @merchant2.id)
    end

    it "When I click on the name of an item from the merchant items index page, Then I am taken to that merchant's item's show page" do
      visit merchant_items_path(@merchant1)

      click_link("#{@item1.name}")
      
      expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(@item1.unit_price)
    end
  end
end