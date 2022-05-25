class VolumesController < ApplicationController
    before_action :authenticate_user!
    
    def new
        @volume = Volume.new
    end

    def create
        @volume = Volume.new(volume_params)
        if @volume.save()
            redirect_to root_path, notice: 'Intervalo de volume cadastrado com sucesso'
        else
            flash.now[:notice] = "Intervalo de volume não cadastrado"
            render 'new'
        end
    end

    private
    def set_volume
      @volume = Volume.find(params[:id])
    end

    def volume_params
      params.require(:volume).permit(:min, :max)
    end
end