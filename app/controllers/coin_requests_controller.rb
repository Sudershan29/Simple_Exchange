class CoinRequestsController < ApplicationController
  before_action :set_coin_request, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:show,:index]
  before_action :right_user, only:[:edit,:update,:destroy]
  
  #one giving Cash is the sender

  def coin_accept2
     @coin_request = CoinRequest.all.find(params[:id])
     @find = Request.where('amount == ? AND value == ? AND user_id!= ?',@coin_request.price,@coin_request.coin, current_user.id).first
     @sender = Account.find_or_create_by(user_id:current_user.id)
     @receiver = Account.find_or_create_by(user_id:@find.user_id)

     if @sender.currency >= @coin_request.price and @receiver.coin >= @coin_request.coin
      temp = @sender.currency - @coin_request.price
      temp2 = @sender.coin + @coin_request.coin

      @sender.update(currency: temp,coin: temp2)
      
      temp = @receiver.currency + @coin_request.price
      temp2 = @receiver.coin - @coin_request.coin
      
      @receiver.update(currency: temp,coin: temp2)

      Transaction.create(sender:@sender.user_id  ,receiver:@receiver.user_id ,amount: @coin_request.price ,value: @coin_request.coin, user_id: current_user.id)
      
      @coin_request.destroy
      @find.destroy

      redirect_to transactions_path

    elsif @sender.currency < @coin_request.price
      redirect_to home_coin_market_path, notice: "You dont have enough balance"
    else
      redirect_to home_coin_market_path, notice: "The receiver doesnt have enough coins to transact"
    end

  end

  def coin_accept
    @request = CoinRequest.all.find(params[:id])
    @sender = Account.find_or_create_by(user_id:@request.user_id)
    @receiver = Account.find_or_create_by(user_id:current_user.id)

    if @sender.currency >= @request.price and @receiver.coin >= @request.coin
      temp = @sender.currency - @request.price
      temp2 = @sender.coin + @request.coin

      @sender.update(currency: temp,coin: temp2)
      
      temp = @receiver.currency + @request.price
      temp2 = @receiver.coin - @request.coin
      
      @receiver.update(currency: temp,coin: temp2)

      Transaction.create(sender:@sender.user_id   ,receiver:current_user.id ,amount: @request.price ,value: @request.coin, user_id: current_user.id)
      
      @request.destroy

      redirect_to transactions_path

    elsif @sender.currency < @request.price
      redirect_to home_coin_market_path, notice: "They do not have enough balance."
    else
      redirect_to home_coin_market_path, notice: "You dont have enough coins"  
    end

  end
  # GET /coin_requests or /coin_requests.json
  def index
    @coin_requests = CoinRequest.where(user_id: current_user.id)
  end

  # GET /coin_requests/1 or /coin_requests/1.json
  def show
    @found_match = Request.where('amount == ? AND value == ? AND user_id!= ?',@coin_request.price,@coin_request.coin, current_user.id).first 
  end

  # GET /coin_requests/new
  def new
    @coin_request = CoinRequest.new 
  end

  # GET /coin_requests/1/edit
  def edit
  end

  def right_user
    @coin_request = current_user.coin_requests.find_by(id: params[:id])
    redirect_to coin_requests_path, notice: "Not authorized." if @coin_request.nil?
  end

  # POST /coin_requests or /coin_requests.json
  def create
    @coin_request = CoinRequest.new(coin_request_params)

    respond_to do |format|
      if @coin_request.save
        format.html { redirect_to @coin_request, notice: "Coin request was successfully created." }
        format.json { render :show, status: :created, location: @coin_request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coin_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coin_requests/1 or /coin_requests/1.json
  def update
    respond_to do |format|
      if @coin_request.update(coin_request_params)
        format.html { redirect_to @coin_request, notice: "Coin request was successfully updated." }
        format.json { render :show, status: :ok, location: @coin_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coin_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coin_requests/1 or /coin_requests/1.json
  def destroy
    @coin_request.destroy
    respond_to do |format|
      format.html { redirect_to coin_requests_url, notice: "Coin request was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coin_request
      @coin_request = CoinRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coin_request_params
      params.require(:coin_request).permit(:sender, :receiver, :coin, :price, :user_id)
    end
end
