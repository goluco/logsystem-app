class CreateDeadlines < ActiveRecord::Migration[7.0]
  def change
    create_table :deadlines do |t|
      t.integer :working_days
      t.integer :min_distance
      t.integer :max_distance

      t.timestamps
    end
  end
end
