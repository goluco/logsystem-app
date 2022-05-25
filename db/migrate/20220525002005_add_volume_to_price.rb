class AddVolumeToPrice < ActiveRecord::Migration[7.0]
  def change
    add_reference :prices, :volume, null: false, foreign_key: true
  end
end
