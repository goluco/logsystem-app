class DeadlinesController < ApplicationController
    def index
        @deadlines = Deadline.all
    end

    def new
        @deadline = Deadline.new
    end

    def create
      @deadline = Deadline.new(deadline_params)
      if @deadline.save()
        redirect_to root_path, notice: 'Nova configuração de prazo adicionada com sucesso'
      else
        flash.now[:notice] = 'Não foi possível adicionar nova configuração de prazo'
        render 'new'
      end
    end
    
    private

    def deadline_params
      params.require(:deadline).permit(:working_days, :min_distance, :max_distance)
    end
end