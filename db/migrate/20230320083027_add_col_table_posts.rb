class AddColTablePosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :comment_flag, :boolean, default: true
  end
end
