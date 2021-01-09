class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices

  validates_presence_of :name

  def top_customers
    # require 'pry'; binding.pry
  end

  def all_items
    
  end
end
