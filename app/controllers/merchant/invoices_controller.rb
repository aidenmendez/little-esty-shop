class Merchant::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    @items = @invoice.items.to_a
    @item_quants = @items.each_with_object({}) do |item, memo|
      memo[item.id] = InvoiceItem.find_by(invoice_id: @invoice.id, item_id: item.id).quantity
    end
  end
end