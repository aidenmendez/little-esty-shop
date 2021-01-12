class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])   
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      flash[:notice] = "Item details updated successfully"
      redirect_to merchant_item_path(item.merchant_id, item.id) 
    else
      redirect_to merchant_item_path(item.merchant_id, item.id), flash[:notice] = "An error occurred, please try again."
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end