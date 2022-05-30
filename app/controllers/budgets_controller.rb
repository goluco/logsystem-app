class BudgetsController < ApplicationController
    before_action :authenticate_admin!

    def index
        @budgets = Budget.all
    end

    def show
        @budget = Budget.find(params[:id])
    end
end