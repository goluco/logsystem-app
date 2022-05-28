class CreateBudgets < ActiveRecord::Migration[7.0]
  def change
    create_table :budgets do |t|
      t.references :carrier, null: false, foreign_key: true
      t.decimal :value

      t.timestamps
    end
  end
end
