class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :items

  validates_presence_of :name

  def self.top_merchants
    joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .where("transactions.result = ?", 1)
    .group(:id)
    .order(total_revenue: :desc)
    .limit(5)
  end

  def best_day
    invoices
    .joins(:invoice_items)
    .select("invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .group(:created_at)
    .order(:total_revenue)
    .first
    .date_time
  end
end
