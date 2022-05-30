class AddInfologToOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :infolog, null: true, foreign_key: true
  end
end
