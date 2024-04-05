class CreatePins < ActiveRecord::Migration[7.0]
  def change
    create_table :pins do |t|
      t.string :title
      t.text :description
      t.string :pin_image
      t.integer :user_id
      t.string :slug

      t.timestamps
    end

    add_index :pins, :slug, unique: true
  end
end
