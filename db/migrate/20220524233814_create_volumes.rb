class CreateVolumes < ActiveRecord::Migration[7.0]
  def change
    create_table :volumes do |t|
      t.decimal :min
      t.decimal :max

      t.timestamps
    end
  end
end
