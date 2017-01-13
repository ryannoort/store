class AddRoleToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :role, :int, null: false
  end
end
