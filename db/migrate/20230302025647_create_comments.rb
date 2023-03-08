class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :comment_id
      t.string :text
      t.string :file

      t.timestamps
    end
  end
end
