class AddSuggestsToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :suggests, :text
  end
end
