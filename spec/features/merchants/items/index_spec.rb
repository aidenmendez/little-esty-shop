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

    it "I see a list of the names of all of my items and none from other merchants" do
      visit merchant_items_path(@merchant1)

      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item3.name)
      expect(page).to have_content(@item4.name)

      expect(page).not_to have_content(@item5.name)
      expect(page).not_to have_content(@item6.name)      
    end

    it "has a link to create an Item" do
      visit merchant_items_path(@merchant1)

      expect(page).to have_link("Create Item")

      click_link("Create Item")

      expect(current_path).to eq(new_merchant_item_path(@merchant1.id))
    end
  end
end