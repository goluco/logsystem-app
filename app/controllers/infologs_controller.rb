class InfologsController < ApplicationController
    before_action :set_infolog

    def show
    end

    def edit
    end

    def update
        if @infolog.update(infolog_params)
          redirect_to infolog_path(@infolog.id), notice: 'Atualizado'
        else
          flash.now[:notice] = 'Não atualizado'
          render 'edit'
        end 
    end

    private
    def set_infolog
        @infolog = Infolog.find(params[:id])
    end

    def infolog_params
      params.require(:infolog).permit(:coordinates, :date, :time)
    end
end