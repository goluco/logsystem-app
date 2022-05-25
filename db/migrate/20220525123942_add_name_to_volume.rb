class AddNameToVolume < ActiveRecord::Migration[7.0]
  def change
    add_column :volumes, :name, :string
  end
end
