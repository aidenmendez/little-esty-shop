require 'rails_helper'

describe "as a merchant" do
  describe "When I click on create item link" do
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

    it "takes me to the new item page" do
      visit merchant_items_path(@merchant1)

      click_link("Create Item")

      expect(current_path).to eq(new_merchant_item_path(@merchant1.id))
    end

    describe "when I visit the new item page" do
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

      it "has a form to create a new item" do
        visit new_merchant_item_path(@merchant1)
        
        fill_in :name, with: 'Guitar'
        fill_in :description, with: "It is hanging on my wall, first thing I saw"
        fill_in :unit_price, with: "100"

        click_on("Create New Item")

        expect(current_path).to eq(merchant_items_path(@merchant1.id))

        expect(page).to have_content("Guitar")
      end
    end
  end
end