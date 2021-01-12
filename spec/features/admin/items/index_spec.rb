require 'rails_helper'

describe 'As a visitor when I visit the admin items index page' do
  it 'Shows the 5 most expensive items' do
    merchant = create(:merchant)
    item1 = create(:item, unit_price: 5, merchant_id: merchant.id)
    item2 = create(:item, unit_price: 10, merchant_id: merchant.id)
    item3 = create(:item, unit_price: 20, merchant_id: merchant.id)
    item4 = create(:item, unit_price: 30, merchant_id: merchant.id)
    item5 = create(:item, unit_price: 40, merchant_id: merchant.id)
    item6 = create(:item, unit_price: 50, merchant_id: merchant.id)

    visit admin_items_path

    expect(page).to have_content([item6.name, item5.name, item4.name, item3.name, item2.name])
    expect(page).to_not have_content([item1.name])
  end

  it 'Shows top 5 merchants' do
    merchant1 = create(:merchant, name: 'E')
    merchant2 = create(:merchant, name: 'D')
    merchant3 = create(:merchant, name: 'C')
    merchant4 = create(:merchant, name: 'B')
    merchant5 = create(:merchant, name: 'A')
    merchant6 = create(:merchant, name: 'F')
    item1 = create(:item, unit_price: 5, merchant_id: merchant1.id)
    item2 = create(:item, unit_price: 20, merchant_id: merchant2.id)
    item4 = create(:item, unit_price: 30, merchant_id: merchant2.id)
    item3 = create(:item, unit_price: 40, merchant_id: merchant3.id)
    item4 = create(:item, unit_price: 50, merchant_id: merchant3.id)
    item5 = create(:item, unit_price: 50, merchant_id: merchant3.id)
    item6 = create(:item, unit_price: 20, merchant_id: merchant4.id)
    item7 = create(:item, unit_price: 30, merchant_id: merchant4.id)
    item8 = create(:item, unit_price: 30, merchant_id: merchant4.id)
    item9 = create(:item, unit_price: 30, merchant_id: merchant4.id)
    item10 = create(:item, unit_price: 40, merchant_id: merchant5.id)
    item11 = create(:item, unit_price: 50, merchant_id: merchant5.id)
    item12 = create(:item, unit_price: 50, merchant_id: merchant5.id)
    item13 = create(:item, unit_price: 50, merchant_id: merchant5.id)
    item14 = create(:item, unit_price: 50, merchant_id: merchant5.id)

    visit admin_items_path

    expect(page).to have_content(merchant5.name)
    expect(page).to have_content(merchant4.name)
    expect(page).to have_content(merchant3.name)
    expect(page).to have_content(merchant2.name)
    expect(page).to have_content(merchant1.name)
    expect(page).to_not have_content(merchant6.name)
  end
end
