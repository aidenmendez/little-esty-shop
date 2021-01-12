class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end


  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    flash.notice = "Merchant successfully updated"
    redirect_to admin_merchant_path(@merchant)
  end

private
 def merchant_params
   params.permit(:name, :status)
 end

  def new
  end

  def create
    merchant = Merchant.create!(merchant_params)
    merchant.save
    redirect_to admin_merchants_path
  end
