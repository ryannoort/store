class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :name
      t.string :email, null: false
      t.string :image
      t.timestamp :last_log
      t.timestamps
    end
  end
end
