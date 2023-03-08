class AddColToTablePost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :group_id, :integer
    add_column :posts, :status, :integer
  end
end
