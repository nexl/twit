class CreateFollows < ActiveRecord::Migration[5.1]
  def change
    create_table :follows do |t|
      t.integer :user_id
      t.integer :followers_id

      t.timestamps
    end
    add_index :follows, [:user_id, :followers_id], unique: true
  end
end
