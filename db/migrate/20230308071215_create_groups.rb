class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.integer :user_id
      t.string :name
      t.string :avatar
      t.boolean :public, default: false
      t.timestamps
    end
  end
end
