class CreateSchedule < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :room_id
      t.integer :user_id
      t.datetime :scheduled_at
      
      t.timestamps
    end
  end
end
