class CreatePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :prices do |t|
      t.decimal :value

      t.timestamps
    end
  end
end
