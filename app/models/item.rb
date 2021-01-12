class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates_presence_of :name, :description, :unit_price

  def get_quants
    require 'pry'; binding.pry
  end
end
