class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.decimal :volume
      t.integer :product_weight
      t.string :delivery_address
      t.string :recipient_name
      t.references :carrier, null: false, foreign_key: true
      t.string :code
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
