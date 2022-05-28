class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :accept, :refuse, :finalize]  
  
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
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:volume, :product_weight, :delivery_address, :recipient_name, :carrier_id)
    end
end