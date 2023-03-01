class CreateRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :relations do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :_type
      t.timestamps
    end
  end
end
