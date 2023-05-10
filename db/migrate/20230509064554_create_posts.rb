class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :genre_id,null: false
      t.integer :user_id,null: false
      t.string :artist_name,null: false
      t.string :song_title,null: false
      t.string :title,null: false
      t.text :content
      t.timestamps
    end
  end
end
