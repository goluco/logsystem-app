class CarriersController < ApplicationController 
    before_action :authenticate_admin!, only: [:edit, :update, :new, :create, :destroy]
    before_action :set_carrier, only: [:edit, :update, :show, :deactivate, :activate]

    def index
      @carriers = Carrier.active 
      @inactive_carriers = Carrier.inactive
    end

    def show
    end

    def new
      @carrier = Carrier.new
    end

    def create 
      @carrier = Carrier.new(carrier_params)
      if @carrier.save()
        redirect_to root_path, notice: 'Transportadora cadastrada com sucesso'
      else
        flash.now[:notice] = 'Transportadora não cadastrada'
        render 'new'
      end
    end

    def edit
    end

    def update
      if @carrier.update(carrier_params)
        redirect_to carrier_path(@carrier.id), notice: 'Dados atualizados com sucesso'
      else
        flash.now[:notice] = 'Dados não atualizados'
        render 'edit'
      end
    end

    def deactivate
      @carrier.inactive!
      redirect_to carrier_path(@carrier.id)
    end

    def activate
      @carrier.active!
      redirect_to carrier_path(@carrier.id)
    end

    private
    def set_carrier
      @carrier = Carrier.find(params[:id])
    end

    def carrier_params
      params.require(:carrier).permit(:trade_name, :corporate_name, :domain, :nif, :address, :city, :state, :status)
    end
end