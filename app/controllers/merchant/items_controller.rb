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
  end

  def create
    Item.create!([
      name: params[:name],
      description: params[:description],
      unit_price: params[:unit_price],
      merchant_id: params[:merchant_id]
      ])
      # require 'pry'; binding.pry
    redirect_to merchant_items_path(params[:merchant_id])
  end

end