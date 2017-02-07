class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :name
      t.integer :role, null: false
      t.string :email, null: false
      t.string :image_url
      t.timestamp :last_log
      t.timestamps
    end
    add_index :users, :email
  end
end
