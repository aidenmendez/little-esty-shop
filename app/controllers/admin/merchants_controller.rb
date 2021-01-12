class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
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
    params.permit(:name)
  end
end
