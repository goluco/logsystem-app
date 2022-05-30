class AddOrderToInfolog < ActiveRecord::Migration[7.0]
  def change
    add_reference :infologs, :order, null: false, foreign_key: true
  end
end
