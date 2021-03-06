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


  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.merchant_id = params[:merchant_id]
    if @item.save
      redirect_to merchant_items_path(params[:merchant_id])
    else
      flash.now[:error] = "Error: Missing or invaild input. Please try again."
      render :new
    end
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