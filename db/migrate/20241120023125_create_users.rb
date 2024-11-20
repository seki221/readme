class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :email, null: false
      t.string :salt
      t.integer :role
      t.string :crypted_password

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
