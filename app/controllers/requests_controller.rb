class RequestsController < ApplicationController
  before_action :set_request, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:show,:index]
  before_action :right_user, only:[:edit,:update,:destroy]
  

  # GET /requests or /requests.json
  def accept
    @request = Request.all.find(params[:id])
    @sender = Account.find_or_create_by(user_id:current_user.id)
    @receiver = Account.find_or_create_by(user_id:@request.user_id)

    if @sender.currency >= @request.amount and @receiver.coin >= @request.value 
      temp = @sender.currency - @request.amount
      temp2 = @sender.coin + @request.value
      
      @sender.update(currency: temp,coin: temp2)
      
      temp = @receiver.currency + @request.amount
      temp2 = @receiver.coin - @request.value
      
      @receiver.update(currency: temp,coin: temp2)

      Transaction.create(sender: current_user.id  ,receiver: @request.user_id ,amount: @request.amount ,value: @request.value, user_id: current_user.id)
      
      @request.destroy

      redirect_to transactions_path

    else
      redirect_to home_market_path, notice: "Not enough balance."
    end

  end

  def index
    @requests = current_user.requests.where(user_id: current_user.id)
  end

  # GET /requests/1 or /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @request = current_user.requests.build    
    #@find = Request.find_or_create_by(amount:@request.amount ,value:@request.value).where.not(user_id: current_user.id)
    #@find = Request.where('amount == ? AND value == ? AND user_id!= ?',@request.amount,@request.value, current_user.id )
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests or /requests.json
  def create
    @request = current_user.requests.build(request_params)

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: "Request was successfully created." }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end    
  end

  def right_user
    @request = current_user.requests.find_by(id: params[:id])
    redirect_to requests_path, notice: "Not authorized." if @request.nil?
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: "Request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: "Request was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:amount, :value, :user_id)
    end
end
