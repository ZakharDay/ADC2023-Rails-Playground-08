class AddSlugToPins < ActiveRecord::Migration[7.0]
  def change
    add_column :pins, :slug, :string
    add_index :pins, :slug, unique: true
  end
end
