class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name
      t.string :avatar
      t.datetime :birthday
      t.string :address
      t.timestamps
    end
  end
end
