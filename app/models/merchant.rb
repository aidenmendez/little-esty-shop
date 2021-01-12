class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items, dependent: :destroy
  has_many :customers, through: :invoices, dependent: :destroy
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name

  def self.top_merchants
    joins([invoices: :transactions], :invoice_items)
    .where("result = ?", 1)
    .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
    .group(:id)
    .order(total_revenue: :desc)
    .limit(5)
  end

  def all_items

  end
end
