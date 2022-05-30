class AddProductAddressToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :product_address, :string
  end
end
