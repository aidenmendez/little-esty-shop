require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
  it { should belong_to :invoice}
  it { should belong_to :item}
  end
  describe 'validations' do
  it { should validate_presence_of :quantity}
  it { should validate_presence_of :unit_price}
  it { should validate_presence_of :status}
  end

  describe 'class methods' do
  it 'Sums Revenue' do
  
  expect(InvoiceItem.total_revenue).to eq(50)
  end
end
end
