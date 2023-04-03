class UpdateBirthdayForProfiles < ActiveRecord::Migration[7.0]
  def up
    change_column :profiles, :birthday, :date
  end

  def down
    change_column :profiles, :birthday, :datetime
  end
end
