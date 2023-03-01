class CreateRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :relations do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :arr
      t.integer :relation_type
      t.timestamps
    end
    add_index :relations, :arr, unique: true
  end
end
