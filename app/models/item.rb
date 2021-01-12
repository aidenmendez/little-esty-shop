class Item < ApplicationRecord
  after_initialize :set_defaults

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates_presence_of :name, :description, :unit_price

  def set_defaults
    self.status = "Disabled"
  end
end
