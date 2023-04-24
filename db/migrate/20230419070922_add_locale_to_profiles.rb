class AddLocaleToProfiles < ActiveRecord::Migration[7.0]
  def change
    add_column :profiles, :locale, :integer
  end
end
