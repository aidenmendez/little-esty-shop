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
   
    end

    it "When I update the information in the form and I click ‘submit’, I'm redirected back to the item show page where I see the updated information" do

    end
  end
end