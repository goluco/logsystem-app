class AddNameToWeight < ActiveRecord::Migration[7.0]
  def change
    add_column :weights, :name, :string
  end
end
