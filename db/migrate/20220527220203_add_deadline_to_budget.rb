class AddDeadlineToBudget < ActiveRecord::Migration[7.0]
  def change
    add_column :budgets, :deadline, :integer
  end
end
