class AddColToTablePost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :group_id, :integer
    add_column :posts, :in_queue, :boolean, default: true
  end
end
