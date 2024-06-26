class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :type
      t.string :title
      t.text :description
      t.text :body
      t.text :url

      t.timestamps
    end
  end
end
