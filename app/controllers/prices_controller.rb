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

    def search
      volume = params[:product_height].to_d * params[:product_width].to_d * params[:product_depth].to_d
      @carriers = Carrier.active
      @budgets = []
      @carriers.each do |carrier|
        @prices = Price.where(carrier_id: carrier)
        @prices.each do |price|
          if (volume <= Volume.find(price.volume_id).max) && (volume >= Volume.find(price.volume_id).min) && (params[:product_weight].to_i <= Weight.find(price.weight_id).max) && (params[:product_weight].to_i >= Weight.find(price.weight_id).min)
            value = nil
            cost = price.value * params[:distance].to_i
            if price.min_charge != nil && cost < price.min_charge
              value = price.min_charge
            else
              value = cost
            end
            deadline = nil
            @deadlines = Deadline.where(carrier: carrier)
            @deadlines.each do |d|
              if params[:distance].to_i < d.max_distance && params[:distance].to_i > d.min_distance
                deadline = d.working_days
              end
            end
            @budgets << Budget.create(carrier: carrier, value: value, deadline: deadline)
          end
        end
      end
    end
    private
    def set_price
      @price = Carrier.find(params[:id])
    end

    def price_params
      params.require(:price).permit(:value, :volume_id, :weight_id, :carrier_id, :min_charge)
    end
end