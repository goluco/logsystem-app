class PricesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update]
    
    def index
        @prices = Price.where(carrier_id: current_user.carrier.id)
    end

    def new
        @price = Price.new
    end

    def create
      @price = Price.new(price_params)
      if @price.save()
        redirect_to root_path, notice: 'Taxa por KM cadastrada com sucesso'
      else
        flash.now[:notice] = 'Taxa por KM não cadastrada'
        render 'new'
      end
    end

    private
    def set_price
      @price = Carrier.find(params[:id])
    end

    def price_params
      params.require(:price).permit(:value, :volume_id, :weight_id, :carrier_id)
    end
end