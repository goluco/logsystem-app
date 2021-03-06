class OrdersController < ApplicationController
  before_action :authenticate_admin!, only: [:new, :create]
  before_action :authenticate_user!, only: [:edit, :accept, :finalize, :refuse, :show]
  before_action :set_order, only: [:show, :edit, :update, :accept, :refuse, :finalize] 
  before_action :set_infolog, only: [:show, :edit, :update] 

  def search
    unique_code = params[:code]
    @order = Order.where(code: unique_code).last
    if @order != nil
      if @order.infolog_id == nil
        @infolog = Infolog.where(order_id: @order.id).last
        @order.infolog_id = @infolog.id
      else
        @infolog = Infolog.find(@order.infolog_id)
      end
    end
  end
  
    def index
        @orders_awaiting = Order.pending_acceptance
        @orders_accepted = Order.accepted
        @orders_refused = Order.refused
        @orders_delivered = Order.finished
        if user_signed_in?
          @orders_user = Order.where(carrier: current_user.carrier)
        end
    end

    def show
      @vehicle = nil
      if @order.vehicle_id != nil
        @vehicle = Vehicle.find(@order.vehicle_id)
      else
        @vehicle = "Ainda não há veículos cadastrados para este pedido"
      end
    end

    def new
      @order = Order.new
    end

    def create      
      @order = Order.new(order_params)
      if @order.save()
        redirect_to root_path, notice: 'Pedido realizado com sucesso'
      else
        flash[:notice] = 'Pedido não realizado. Revisar os campos'
        render 'new'
      end
    end

    def edit
    end

    def update
      if @order.update(order_params)
        redirect_to order_path(@order.id), notice: 'Atualizado'
      else
        flash.now[:notice] = 'Não atualizado'
        render 'edit'
      end 
    end

    def accept
      @order.accepted!
      redirect_to order_path(@order.id)
    end

    def refuse
      @order.refused!
      redirect_to order_path(@order.id)
    end

    def finalize
      @order.finished!
      redirect_to order_path(@order.id)
    end

    private

    def set_infolog
      if @order.infolog_id == nil
        @infolog = Infolog.where(order_id: @order.id).last
        @order.infolog_id = @infolog.id
      else
        @infolog = Infolog.find(@order.infolog_id)
      end
    end

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:volume, :product_weight, :delivery_address, :recipient_name, :carrier_id, :product_sku, :product_address, :distance, :vehicle_id, :infolog_id)
    end
end