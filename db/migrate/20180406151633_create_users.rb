class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :password_digest
      t.string :register_digest
      t.boolean :activate
      
      t.timestamps
    end
  end
end
