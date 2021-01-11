class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items, dependent: :destroy
  has_many :customers, through: :invoices, dependent: :destroy

  validates_presence_of :name

  def top_customers
    # require 'pry'; binding.pry
  end

  def all_items
    
  end
end
