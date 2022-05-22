class AddCityToCarrier < ActiveRecord::Migration[7.0]
  def change
    add_column :carriers, :city, :string
  end
end
