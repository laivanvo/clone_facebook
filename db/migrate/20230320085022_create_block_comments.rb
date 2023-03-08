class CreateBlockComments < ActiveRecord::Migration[7.0]
  def change
    create_table :block_comments do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps
    end
    add_index :block_comments, [:post_id, :user_id], unique: true
  end
end
