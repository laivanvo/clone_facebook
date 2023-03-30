class CreateReactions < ActiveRecord::Migration[7.0]
  def change
    create_table :reactions do |t|
      t.integer :user_id
      t.integer :ta_duty_id
      t.string :ta_duty_type
      t.timestamps
    end
  end
end
