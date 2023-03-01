class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :mode, null: false, default: 0
      t.string :text
      t.json :content
      t.timestamps
    end
  end
end
