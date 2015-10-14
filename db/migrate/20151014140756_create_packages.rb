class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :version
      t.text :title

      t.timestamps null: false
    end

    add_index :packages, [:name, :version], unique: true
  end
end
