class CreateTweets < ActiveRecord::Migration[5.1]
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.string :message, limit: 140

      t.timestamps
    end
  end
end
