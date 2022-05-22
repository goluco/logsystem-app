class CreateCarriers < ActiveRecord::Migration[7.0]
  def change
    create_table :carriers do |t|
      t.string :trade_name
      t.string :corporate_name
      t.string :domain
      t.integer :nif
      t.string :address

      t.timestamps
    end
  end
end
