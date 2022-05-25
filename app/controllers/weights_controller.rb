class WeightsController < ApplicationController
    before_action :authenticate_user!
    
    def new
        @weight = Weight.new
    end

    def create
        @weight = Weight.new(weight_params)
        if @weight.save()
            redirect_to root_path, notice: 'Intervalo de peso cadastrado com sucesso'
        else
            flash.now[:notice] = "Intervalo de peso não cadastrado"
            render 'new'
        end
    end

    private
    def set_weight
      @weight = Weight.find(params[:id])
    end

    def weight_params
      params.require(:weight).permit(:min, :max)
    end
end