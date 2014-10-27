class CreateContactGroups < ActiveRecord::Migration
  def change
    create_table :contact_groups do |t|
      t.integer :contact_id, null: false
      t.integer :group_id, null: false
      t.timestamps
    end
    
    add_index :contact_groups, :contact_id
    add_index :contact_groups, :group_id
    add_index :contact_groups, [:contact_id, :group_id], unique: true
  end
end
