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
end
