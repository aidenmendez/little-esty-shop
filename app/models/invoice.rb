class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  belongs_to :merchant

  validates_presence_of :status

  enum status: ['in progress', :completed, :cancelled]

  def self.incomplete_invoices
    where(status: 0).order(created_at: :asc).distinct
  end

  def format_date
    created_at.strftime("%A, %b %d, %Y")
  end

  def date_time
    created_at.strftime("%A, %B %d, %Y")
  end
end
