require 'rails_helper'

describe 'As a visitor when I visito a admin merchant show page' do
  before(:each) do
    Merchant.destroy_all
    @merchant_1 = Merchant.create!(name: 'House of thingys')
    @merchant_2 = Merchant.create!(name: 'House of mirros')
    @merchant_3 = Merchant.create!(name: 'House of horrors')
  end
  it 'Can update merchants information' do

    visit admin_merchant_path(@merchant_1)

    click_on "Edit Merchant"

    expect(page).to have_content(@merchant_1.name)

    fill_in :name, with: "House of Fun"

    click_on 'Submit'

    expect(current_path).to eq(admin_merchant_path(@merchant_1))
    expect(page).to have_content("House of Fun")
    expect(page).to have_content("Merchant successfully updated")
  end
end
