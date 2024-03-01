class CreatePinsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :pins_users do |t|
      t.integer :pin_id
      t.integer :user_id

      t.timestamps
    end
  end
end
