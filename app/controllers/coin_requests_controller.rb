class CoinRequestsController < ApplicationController
  before_action :set_coin_request, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:show,:index]
  before_action :right_user, only:[:edit,:update,:destroy]
  
  # GET /coin_requests or /coin_requests.json
  def index
    @coin_requests = CoinRequest.all
  end

  # GET /coin_requests/1 or /coin_requests/1.json
  def show
  end

  # GET /coin_requests/new
  def new
    @coin_request = CoinRequest.new
  end

  # GET /coin_requests/1/edit
  def edit
  end

  def right_user
     @coin_request = current_user.coinRequest.find_by(id: params[:id])
    redirect_to coin_requests_path, notice: "Not authorized." if @request.nil?
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
