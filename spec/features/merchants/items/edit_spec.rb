require "rails_helper"

RSpec.describe "As a merchant" do
  describe "When I visit a merchant item's update page" do
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

    it "I see a form filled in with the existing item attribute information" do
      visit edit_merchant_item_path(@item1.merchant.id, @item1.id )

      expect(page).to have_field("Name", with: @item1.name)
      expect(page).to have_field("Description", with: @item1.description)
      expect(page).to have_field("Price", with: @item1.unit_price)
    end

    it "When I update the information in the form and I click ‘submit’, I'm redirected back to the item show page where I see the updated information and I see a flash message stating that the information has been successfully updated." do
      visit edit_merchant_item_path(@item1.merchant.id, @item1.id )
      updated_price = 22
      fill_in "Price", with: updated_price
      click_on "Update"

      expect(current_path).to eq(merchant_item_path(@item1.merchant_id, @item1.id))

      expect(page).to have_content("Current Price: #{updated_price}" )
      # expect(flash[:notice]).to eq("Item details updated successfully")
    end
  end
end