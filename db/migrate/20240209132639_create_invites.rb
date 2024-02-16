class CreateInvites < ActiveRecord::Migration[7.0]
  def change
    create_table :invites do |t|
      t.integer :inviter_id
      t.integer :invitee_id
      t.string :email
      t.text :token

      t.timestamps
    end
  end
end
