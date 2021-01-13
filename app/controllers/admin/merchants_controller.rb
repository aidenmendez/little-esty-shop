class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
    @top_five_merchants = Merchant.top_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end


  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:update_to] == 'disabled'
      merchant.update(status: 1)
      merchant.save
      redirect_to admin_merchants_path
    elsif params[:update_to] == 'enabled'
      merchant.update(status: 0)
      merchant.save
      redirect_to admin_merchants_path
    else
    merchant.update(merchant_params)
    flash.notice = "Merchant successfully updated"
    redirect_to admin_merchant_path(merchant)
    end
  end

  def new
  end

  def create
    merchant = Merchant.create!(merchant_params)
    merchant.save
    redirect_to admin_merchants_path
  end

private
 def merchant_params
   params.permit(:name, :status)
 end
end
