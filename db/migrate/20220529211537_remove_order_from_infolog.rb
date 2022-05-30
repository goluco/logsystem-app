class RemoveOrderFromInfolog < ActiveRecord::Migration[7.0]
  def change
    remove_reference :infologs, :order, null: false, foreign_key: true
  end
end
