class VehiclesController < ApplicationController
    before_action :authenticate_user!

    def new
        @vehicle = Vehicle.new
    end

    def create
        @vehicle = Vehicle.new(vehicle_params)
        if @vehicle.save()
            redirect_to root_path, notice: 'Veículo cadastrado com sucesso'
        else
            flash.now[:notice] = "Veículo não cadastrado."
            render 'new'
        end
    end

    private
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    def vehicle_params
      params.require(:vehicle).permit(:license_plate, :brand, :model, :fabrication_year, :max_capacity, :carrier_id)
    end
end