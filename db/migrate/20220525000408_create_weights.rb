class CreateWeights < ActiveRecord::Migration[7.0]
  def change
    create_table :weights do |t|
      t.integer :min
      t.integer :max

      t.timestamps
    end
  end
end
