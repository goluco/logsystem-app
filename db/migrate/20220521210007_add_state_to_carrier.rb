class AddStateToCarrier < ActiveRecord::Migration[7.0]
  def change
    add_column :carriers, :state, :string
  end
end
