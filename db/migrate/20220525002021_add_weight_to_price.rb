class AddWeightToPrice < ActiveRecord::Migration[7.0]
  def change
    add_reference :prices, :weight, null: false, foreign_key: true
  end
end
