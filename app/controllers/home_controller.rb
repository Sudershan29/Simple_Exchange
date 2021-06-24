class HomeController < ApplicationController
  def index
  end

  def market
  	if user_signed_in?
    	@requests = Request.where.not(user_id: current_user.id)
    	@requests = @requests.order(params[:sort]).reverse_order
    else
    	@requests = Request.all
    	@requests = @requests.order(params[:sort]).reverse_order
  	end
  end

  def coin_market
    if user_signed_in?
      @coin_requests = CoinRequest.where.not(user_id: current_user.id)
      @coin_requests = @coin_requests.order(params[:sort]).reverse_order
    else
      @coin_requests = CoinRequest.all
      @coin_requests = @coin_requests.order(params[:sort]).reverse_order
    end
  end
end
