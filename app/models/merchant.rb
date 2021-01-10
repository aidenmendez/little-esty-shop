class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items, dependent: :destroy
  has_many :customers, through: :invoices, dependent: :destroy

  validates_presence_of :name
end
