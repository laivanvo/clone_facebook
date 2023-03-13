class CreateMemberRelations < ActiveRecord::Migration[7.0]
  def change
    create_table :member_relations do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :relation_type
      t.timestamps
    end
  end
end
