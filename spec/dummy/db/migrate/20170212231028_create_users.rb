class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email,              null: false, default: ""
      t.string :password_digest, null: false, default: ""

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.string :phone
    end
    
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end