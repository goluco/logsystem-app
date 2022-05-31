class AddMinChargeToPrice < ActiveRecord::Migration[7.0]
  def change
    add_column :prices, :min_charge, :decimal
  end
end
