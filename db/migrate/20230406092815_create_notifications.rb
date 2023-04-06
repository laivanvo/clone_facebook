class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :ta_duty_id
      t.string :ta_duty_type
      t.integer :noti_type
      t.string :path
      t.boolean :viewed, default: false
      t.timestamps
    end
  end
end
