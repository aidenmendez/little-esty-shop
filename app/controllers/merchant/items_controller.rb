class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])   
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    require 'pry'; binding.pry
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.merchant_id = params[:merchant_id]
    @item.save
    redirect_to merchant_items_path(params[:merchant_id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end