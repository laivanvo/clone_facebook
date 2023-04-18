class CreateContents < ActiveRecord::Migration[7.0]
  def change
    create_table :contents do |t|
      t.integer :post_id
      t.string :file
      t.string :caption
      t.timestamps
    end
  end
end
