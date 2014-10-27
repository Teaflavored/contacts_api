class EditUsers < ActiveRecord::Migration
  def change
    remove_index :users, column: :email
    remove_column :users, :name
    remove_column :users, :email
    add_column :users, :username, :string, null: false
    add_index :users, :username, unique: true
  end
  
  
end
