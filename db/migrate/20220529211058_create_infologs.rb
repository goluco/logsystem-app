class CreateInfologs < ActiveRecord::Migration[7.0]
  def change
    create_table :infologs do |t|
      t.string :coordinates
      t.string :date
      t.string :time

      t.timestamps
    end
  end
end
