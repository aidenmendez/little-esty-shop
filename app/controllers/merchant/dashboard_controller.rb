class Merchant::DashboardController < ApplicationController

  def index
<<<<<<< HEAD
    # require 'pry'; binding.pry
    @merchant = Merchant.find(params[:merchant_id])
  end
end
=======
    @merchant = Merchant.find(params[:merchant_id])
  end
end
>>>>>>> 74047d40c3af3c61300bce2e90b40d4455b0324c
