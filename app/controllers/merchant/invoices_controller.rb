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
    @item_data = @items.each_with_object({}) do |item, memo|
      memo[item.id] = {
        quantity: InvoiceItem.find_by(invoice_id: @invoice.id, item_id: item.id).quantity,
        unit_price: InvoiceItem.find_by(invoice_id: @invoice.id, item_id: item.id).unit_price,
        status: InvoiceItem.find_by(invoice_id: @invoice.id, item_id: item.id).status
      }
    end
  end
end