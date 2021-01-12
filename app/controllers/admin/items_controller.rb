class Admin::ItemsController < ApplicationController

  def index
    @items = Item.top_five
    @merchants = Merchant.top_five_by_item_count
  end
end
